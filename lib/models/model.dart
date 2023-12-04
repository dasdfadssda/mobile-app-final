import 'package:cloud_firestore/cloud_firestore.dart';

class Wish { //파이어 스토에서 정보 읽기 위해 가져오기 
  late String content;
  late String displayName;
  late String id;
  late String imageUrl;
  late String price;
  late String title;
  late List wish;


  Wish({
    required this.content,
    required this.displayName,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.wish,
  });
  
  Wish.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    content = data['content'];
    displayName = data['displayName'];
    id = data['id'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    title = data['title'];
    wish = data['wish'];
  }
}


