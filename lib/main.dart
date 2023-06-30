import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';

import 'package:test1/second_page.dart';

import 'home_page.dart';



FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

bool isPost = false;

Future<void> initDynamicLinks() async {

  dynamicLinks.onLink.listen((dynamicLinkData) {

    debugPrint('Url: ${dynamicLinkData.link}');

    isPost = dynamicLinkData.link.toString().contains('secondpage');

    print(isPost);

  }).onError((error) {

    debugPrint('onLink error');

    debugPrint(error.message);

  });

}





void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}



class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: const MyHomePage(title: 'First Page'),

      routes: {


        'secondPage': (context) => const SecondPage(),

      },

    );

  }

}