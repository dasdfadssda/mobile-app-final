
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/auth_service.dart';
import 'Home.dart';



class ADDPAGE extends StatefulWidget {
  const ADDPAGE({super.key});

  @override
  State<ADDPAGE> createState() => _ADDPAGEState();
}

class _ADDPAGEState extends State<ADDPAGE> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading:TextButton(
        child: Text('cancel'),
        onPressed: () {
         Navigator.pop(context);
        },
      ),
      title: Text("ADD", style: TextStyle(color: Colors.black),),
      actions: [
        TextButton(
              onPressed: () async{
                contentsFunction(FirebaseAuth.instance.currentUser!.displayName!,_photo,TitleController,contentsController,PriceController);
             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          );
              },
              child: Text('Save'))
      ],
    ),
        body: Column(children: [
          Container(
            child: _photo != null ? Image.file(_photo!,height: 300, width: double.infinity,) : _CameraButton(),
          ), // 카메라 사진 혹은 내가 올릴 사진
          Align(
            alignment: Alignment.centerRight,
            child: cameraButton(),
          ),
          TitleText(),
          PriceText(),
          ContentsText()
        ],)
    );
  }


      Widget _CameraButton() { // 사진 추가 버튼 
    return  InkWell(
        child: Container(
          decoration: BoxDecoration(
       border: Border.all( 
         width: 1,
         color: Colors.blueAccent, 
      ),),
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.camera_alt_rounded, color: Color(0xff4262A0), size: 100,),
               SizedBox(height: 10,),
          ],),
        ),
    );
  }


  Widget cameraButton() {
    return IconButton(
      onPressed: imgFromGallery, 
      icon: Icon(Icons.camera_alt));
  }
  final TitleController = TextEditingController();
  final PriceController = TextEditingController();
  final contentsController = TextEditingController();

  Widget TitleText() { // 글 제목
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 200),
            child: TextFormField(
               maxLines: 3,
               minLines: 1,
              controller: TitleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: 'Product Name',
              ),
            ),
          );
  }

  Widget PriceText() { // 글 내용
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
            child: TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: PriceController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: 'Price',
              ),
            ),
          );
  }

  Widget ContentsText() { // 글 내용
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
            child: TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: contentsController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: 'decription',
              ),
            ),
          );
  }
}