import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mafinal/Auth/auth_service.dart';
import 'package:mafinal/models/model_provider.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class WishPaage extends StatefulWidget {
  const WishPaage({super.key});

  @override
  State<WishPaage> createState() => _WishPaageState();
}

class _WishPaageState extends State<WishPaage> {
  @override
  Widget build(BuildContext context) {
    List nell=[];
    int num = 1;
        final contentsProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('wishlist'),
      ),
      body: FutureBuilder(  // 화면 만들기! 
      future: contentsProvider.fetchItems(),
      builder: (context, snapshots) {
        if (contentsProvider.items.length == 0) {
          return Center(
            child:Text('없어 내용')
          );
        } else {
          return ListView.builder(
              itemCount: contentsProvider.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  shape:  RoundedRectangleBorder( 
                  side: BorderSide(width: 1),
                ),
                  leading:  Image.network(contentsProvider.items[index].imageUrl),
                   title: Text('${contentsProvider.items[index].title}'),
                   trailing: IconButton(
                     icon: Icon(Icons.delete),
                     onPressed: (){
                      FirebaseFirestore.instance.collection("${FirebaseAuth.instance.currentUser!.displayName!}Wish").doc(contentsProvider.items[index].price).delete().whenComplete(() => print('위시리스트 취소'));
                      print(1);
                      contentsProvider.items[index].wish.remove(contentsProvider.items[index].price);
                       nell = contentsProvider.items[index].wish;
                       print(nell);
                    //    print(2);
                      wishupdateTowish(FirebaseAuth.instance.currentUser!.displayName,contentsProvider.items[index].price,num,nell);
                     },
                   ),
                );
              }
          );
        }
      },
    ),
    );
  }
}