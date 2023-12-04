import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mafinal/firebase_options.dart';
import 'package:mafinal/models/model_provider.dart';

import 'Auth/auth_service.dart';
import 'Screen/detailPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    ChangeNotifierProvider<ItemProvider>(
      create: (context) => ItemProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/',
      routes : {    //route 설정
      // '/' :(context) => MyApp(),
      '/detail' : ((context) => DetailScreen())},
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthService().handleAuthState(),
    );
  }
}
