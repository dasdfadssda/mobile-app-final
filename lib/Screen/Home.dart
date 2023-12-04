import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafinal/Auth/auth_service.dart';
import 'package:mafinal/Screen/profile.dart';
import 'package:mafinal/Screen/wish.dart';

import 'AddPage.dart';

import 'package:flutter/material.dart';

const List<String> list = <String>['ASC', 'DESC'];

int indexxxx=0;
String idName = '';
String _displayName = '';
String _uid = '';
String idTitle ='';
String  idContents = '';
String _url = '';
List _wish = [];

class code extends ChangeNotifier {
  final int codenum = indexxxx;
  final String price = idName;
   final String displayName = _displayName;
   final String uid = _uid;
    final String title = idTitle;
    final String content= idContents;
     final String url= _url;
     final List wish = _wish;
  notifyListeners();
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  
}
// snapshot.data!.docs[index][''] // 불러올 떄 쓰는 방법
class _HomePageState extends State<HomePage> {
  
final FirebaseAuth _auth = FirebaseAuth.instance;
var _toDay = DateTime.now(); // 시간 비교 하기
int _mylike = 0;
bool _ASC = false;
    String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F5),
      appBar:  AppBar( // 앱바
        elevation: 0,
      leading: IconButton( // 추후 검색 버튼 
          onPressed: () {
            print(FirebaseAuth.instance.currentUser!.uid);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage()));
          }, 
          icon: Icon(Icons.account_circle)),
      title: Text('Welcome'),
      actions: [
        Row(children: [
           IconButton( 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishPaage()));
                print('위시리스트 페이지 이동');
          }, 
          icon: Icon(Icons.shopping_cart)),
          IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ADDPAGE()));
                print('글쓰기 페이지 이동');
          }, 
          icon: Icon(Icons.add)),
          SizedBox(width: 23.2)
        ]) 
      ],
      ),
     body : Column(children: [
       Center(
         child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          // ASC', 'DESC
          dropdownValue = value!;
          if(value == 'ASC') {
            _ASC = false;
          } else {
            _ASC = true;
          }
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )
       ),
       Expanded(
         child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Product').orderBy('price', descending: _ASC).snapshots(),
          // stream: FirebaseFirestore.instance.collection('Product').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: Text('  업로드 된\n글이 없어요 :('));
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio : 2 /2.23,
                    crossAxisCount :2
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.all(10),
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(19, 17, 19, 12.43),
              child: Column(
                children: [
                          Image.network(snapshot.data!.docs[index]['imageUrl'].toString(),height: 106,),
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Column(children: [
                          Text(snapshot.data!.docs[index]['title'].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(snapshot.data!.docs[index]['price'].toString(),style: TextStyle(),),
                   ]),
                 ),
                 Align(
                   alignment: Alignment.bottomRight,
                   child: TextButton(
                         child: Text('more',style: TextStyle(color: Colors.blueAccent)),
                         onPressed: () async{
                           idName = snapshot.data!.docs[index]['price'];
                           idTitle =snapshot.data!.docs[index]['title'];
                           idContents =snapshot.data!.docs[index]['content'];
                           indexxxx = index;
                           _displayName = snapshot.data!.docs[index]['displayName'];
                           _uid = snapshot.data!.docs[index]['uid'];
                           _url = snapshot.data!.docs[index]['imageUrl'];
                           _wish = snapshot.data!.docs[index]['wish'];
                              Navigator.pushNamed(context, '/detail',
                                  arguments: _ASC? snapshot.data!.docs.length-1 - index : index);
                                    print(snapshot.data!.docs[index]['id']);})
                 )
                  ])
                          ),
                        ),
                        _Wish(snapshot.data!.docs[index]['wish']) ? Icon(Icons.check_circle) : Text('')
                      ],
                    );
                    }
                   );
          }),
       ),
     ],)
    );
  } 
  _Wish(wish){
    bool kddd = false;
    for(int i=0; i<wish.length; i++) {
      if(wish[i] == FirebaseAuth.instance.currentUser!.displayName!){
       kddd = true;
      }else {
        kddd =false;
      }
    }
    return kddd;
  }
}