// // models/model_item_provider.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'model.dart';


// class ItemProvider with ChangeNotifier {
//   late CollectionReference itemsReference;
//   List<Wish> items = [];

//   ItemProvider({reference}) {
//     itemsReference = reference ?? FirebaseFirestore.instance.collection('Wish');
//   }

//   Future<void> fetchItems() async {
//     items = await itemsReference.get().then( (QuerySnapshot results) {
//       return results.docs.map( (DocumentSnapshot document) {
//         return Wish.fromSnapshot(document);
//       }).toList();
//     });
//     notifyListeners();
//   }
// }
// models/model_item_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafinal/models/model.dart';


class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Wish> items = [];

  ItemProvider({reference}) {
    itemsReference = reference ?? FirebaseFirestore.instance.collection('${FirebaseAuth.instance.currentUser!.displayName}Wish');
  }

  Future<void> fetchItems() async {
    items = await itemsReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return Wish.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}
