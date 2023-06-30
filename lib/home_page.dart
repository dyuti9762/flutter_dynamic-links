import 'dart:async';



import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';

import 'package:test1/second_page.dart';



class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;



  @override

  State<MyHomePage> createState() => _MyHomePageState();

}



class _MyHomePageState extends State<MyHomePage> {

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  var deepLinkValue;



  Future<void> initDynamicLinks() async {

    try{

      final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

      final Uri? deepLink = data?.link;



      if (deepLink != null) {

        setState(() {

          deepLinkValue = data?.link;

        });

        Timer(const Duration(seconds: 2), (){

          debugPrint('deeplink ${deepLinkValue}');
          if(deepLinkValue.toString().contains('secondpage')){

            Navigator.pushNamed(context, 'secondPage');

          } else {

            Navigator.push(

              context,

              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Welcome',)),

            );

          }

        });





      }

    } catch (e){

      debugPrint('Dynamic link initialization error: $e');

    }



    dynamicLinks.onLink.listen((dynamicLinkData) {

      debugPrint('Url: ${dynamicLinkData.link}');

      var isPost = dynamicLinkData.link.toString().contains('secondpage');

      print(isPost);

      Timer(const Duration(seconds: 2), () {

        if (isPost == true) {

          Navigator.pushNamed(context, 'secondPage');

        } else {

          Navigator.push(

            context,

            MaterialPageRoute(builder: (context) => MyHomePage(title: '$isPost',)),

          );



        }

      });



    }).onError((error) {

      debugPrint('onLink error');

      debugPrint(error.message);

    });

  }



  @override

  void initState(){

    super.initState();

    initDynamicLinks();

    //handleDynamicLinks(context);

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),

      ),

      body: const Center(

        child: Text(

          'Welcome',

        ),

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: (){

          Navigator.pushNamed(context, 'secondPage');

        },

        child: const Icon(Icons.arrow_circle_right),

      ), // This trailing comma makes auto-formatting nicer for build methods.

    );

  }

}