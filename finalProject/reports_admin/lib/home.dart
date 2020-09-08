import 'package:flutter/material.dart';

import 'ListPage.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tidings!'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation:  10.0,
        ),
        
      
      body: ListPage(),
     
      
    );
  }
}