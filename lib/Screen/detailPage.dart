import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/auth_service.dart';
import 'Home.dart';


class DetailScreen extends StatefulWidget {

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File? _photo;
   final ImagePicker _picker = ImagePicker();
   var downloadUrl= 'https://handong.edu/site/handong/res/img/logo.png';

// 사진 가져오기
  Future imgFromGallery() async {
    final image = await _picker.pickImage(
        source: ImageSource.gallery);
        if(image == null) return;
        final imagePhoto = File(image.path);
    setState(() {
     this._photo = imagePhoto;
     print('사진 고름');
    });
  }
  final TitleController = TextEditingController(text: '${code().title}');
  final PriceController = TextEditingController(text : code().price);
  final contentsController = TextEditingController(text :code().content);
    Icon fab = Icon(
    Icons.shopping_cart,
  );
    bool _Revise = false;
  int fabIconNumber = 1;
  
  @override
  Widget build(BuildContext context) {
    
    int _mylike = 0;
     int _Likes = 0;
     IconData icon = Icons.check_circle;
    final _index = ModalRoute.of(context)!.settings.arguments;
    int _Index = int.parse(_index.toString());
    return Scaffold(
      appBar: AppBar(
        leading: _Revise ? 
        TextButton(
          onPressed: (){
            setState(() {
              _Revise = false;
            });
          }, 
          child: Text('cancel',style: TextStyle(color: Colors.black)))
           : IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Color(0XFFCFD2D9),),
          onPressed: () {
             Navigator.pop(context);
          },
        ),
        elevation: 1,
        title: Text('detail'),
        actions: [
          _Revise ? 
          TextButton(
          onPressed: (){
            contentsUpdate(FirebaseAuth.instance.currentUser!.displayName,_photo,TitleController,contentsController,PriceController,code().url);
              _Revise = false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }, 
          child: Text('save',style: TextStyle(color: Colors.white)))
        : Row(children: [
          IconButton(onPressed: () {
           setState(() {
              if(code().uid ==FirebaseAuth.instance.currentUser!.uid) {
            print('수정 시작');
            _Revise = true;
            print(_Revise);
                } else {
                  print('응 아냐');
                }           
           });
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {
            if(code().uid ==FirebaseAuth.instance.currentUser!.uid) {
                          FirebaseFirestore.instance.collection("Product").doc(code().price).delete().whenComplete((){
                            print('삭제 완료'); 
                           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );});
                print('맞음');
                } else {
                  print('응 아냐');
                }
          }, 
          icon: Icon(Icons.delete)),
        ],) 
        ],
      ),
      body:Column(children: [
           StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Product').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              if(_Revise==true){
                return Container( // 수정 
                  child: Column(children: [
                     Container(
            child: _photo != null ? Image.file(_photo!,height: 300, width: double.infinity,) : Image.network(snapshot.data!.docs[_Index]['imageUrl'],height: 200,),
          ),
                 SizedBox(height: 50),
                 Align(
                   alignment: Alignment.topRight,
                   child: cameraButton(),
                 ),
                 TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: TitleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: PriceController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: contentsController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
              ),
            ),
                  ]),
                );
              }else {
                return  Container( // 본폐이지
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(children: [
                 Image.network(snapshot.data!.docs[_Index]['imageUrl'],height: 200,),
                 SizedBox(height: 50),
                 Container(
                   child: Row(children: [
                     Text(snapshot.data!.docs[_Index]['title']),
                     SizedBox(width:200),
                     IconButton(
                       onPressed: () {
                         setState(() {
                     if(snapshot.data!.docs[_Index]['like'].length != 0){
                             for(int i=0; i<snapshot.data!.docs[_Index]['like'].length; i++) {
                             if(snapshot.data!.docs[_Index]['like'][i] == FirebaseAuth.instance.currentUser!.displayName!) {
                               print('있어');
                                final snackBar = SnackBar(
                           content: const Text('you can do it only once !'),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                              ),
                              );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                               break;
                             } else {
                               print('없어');
                              LikeFunction(snapshot.data!.docs[_Index]['like'],snapshot.data!.docs[_Index]['id'],FirebaseAuth.instance.currentUser!.displayName!,);
                                final snackBar = SnackBar(
                           content: const Text('I Like It!'),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                              ),
                              );
                             }
                           }
                     } else {
                         final _snackBar = SnackBar(
                           content: const Text('I Like IT!'),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                              ),
                              );
                           ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                       LikeFunction(snapshot.data!.docs[_Index]['like'],snapshot.data!.docs[_Index]['id'],FirebaseAuth.instance.currentUser!.displayName!,);
                     }
                       });},
                        icon: Icon(Icons.thumb_up,color: Colors.red,)),
                     Text(snapshot.data!.docs[_Index]['like'].length.toString(),style: TextStyle(color: Colors.red),)
                   ],),
                 ),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Text('${snapshot.data!.docs[_Index]['price'].toString()}',style: TextStyle(color: Colors.blue),)),
                Divider(height: 40,thickness: 3),
                Align(
                   alignment: Alignment.centerLeft,
                   child: Text('${snapshot.data!.docs[_Index]['content'].toString()}',style: TextStyle(color: Colors.blue),)),
                   SizedBox(height: 300,),
                   Align(
                   alignment: Alignment.bottomLeft,
                   child: Text('creater : <${snapshot.data!.docs[_Index]['uid'].toString()}>',style: TextStyle(color: Colors.grey),)),
                   Column(
                     children: [
                       Align(
                       alignment: Alignment.bottomLeft,
                       child: Text('${snapshot.data!.docs[_Index]['datetime'].toString()} Created',style: TextStyle(color: Colors.grey))),
                       Text('${snapshot.data!.docs[_Index]['modify'].toString()} Modified',style: TextStyle(color: Colors.grey))
                     ],
                   ),
              ],
              ),
            ); 
              }
            } else {
              return Text('없다');
            }
          }),
        ]),
      floatingActionButton: FloatingActionButton(
        child: fab,
        onPressed: () => setState(() {
          if (fabIconNumber == 0) {
            fab = Icon(
              Icons.shopping_cart,
            );
            fabIconNumber = 1;
             FirebaseFirestore.instance.collection("${FirebaseAuth.instance.currentUser!.displayName!}Wish").doc(code().price).delete().whenComplete(() => print('위시리스트 취소'));
             code().wish.remove(FirebaseAuth.instance.currentUser!.displayName!);
                wishupdate(user,PriceController,fabIconNumber, code().wish);
          } else {
             fabIconNumber = 0;
            Wishlist(FirebaseAuth.instance.currentUser!.displayName,TitleController,contentsController,PriceController,code().url,code().wish);
            code().wish.add(FirebaseAuth.instance.currentUser!.displayName);
            wishupdate(FirebaseAuth.instance.currentUser!.displayName,PriceController,fabIconNumber,code().wish);
            fab = Icon(Icons. check);
          }
        }),
      ),
    );
  }
  Widget cameraButton() {
    return IconButton(
      onPressed: imgFromGallery, 
      icon: Icon(Icons.camera_alt));
  }    
}