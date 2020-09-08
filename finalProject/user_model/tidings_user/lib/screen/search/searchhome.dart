import 'package:flutter/material.dart';
import 'package:tidings_user/screen/search/ssearchlisstpage.dart';

class SearchHome extends StatefulWidget {

  final String event,month;
 SearchHome({this.event,this.month});
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
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
        
      
      body: SearchListPage(event : widget.event,month : widget.month),
      
      
      
    );
  }
}