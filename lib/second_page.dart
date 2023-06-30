import 'package:flutter/material.dart';



class SecondPage extends StatelessWidget {



  const SecondPage({Key? key}) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('2nd Page'),

      ),

      body: const Center(child: Text('2nd Page'),),

    );

  }

}