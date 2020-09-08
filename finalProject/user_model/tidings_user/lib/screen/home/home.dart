import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/models/ListPage.dart';
import 'package:tidings_user/screen/Bot/bot.dart';
import 'package:tidings_user/screen/Profile/profilePage.dart';
import 'package:tidings_user/screen/search/search.dart';
import 'package:tidings_user/service/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = new AuthService();
  

  String name;
  String branch;
  String college;
  String email;

  int _selectedIndex = 0;
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  void _onItemTapped(int index) {
    if(index == 0){
      Fluttertoast.showToast(
        msg: "You're in HOME!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
      
    }
    
    if(index == 1){
      Fluttertoast.showToast(
        msg: "Recommendations!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
      setState(() {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Search()));
        _selectedIndex = index;
            });
    }
    if(index == 2){
      Fluttertoast.showToast(
        msg: "ChatBot for you!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
      setState(() {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Bot()));
        _selectedIndex = index;
      });
      
    }
    if(index == 3){
      Fluttertoast.showToast(
        msg: "Profile Page!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
      setState(() {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profilepage(name: name,email: email,branch: branch,college: college,)));
        _selectedIndex = index;
      });
    }
  }

  @override
  
  Widget build(BuildContext context) {
    createRecord();
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tidings!'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation:  10.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: ()async {await _auth.signOut();}, icon: Icon(Icons.person), label: Text("Logout")),

        ],
        ),
        
      
      body: ListPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
        
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.adb),
            title: Text('Chat Bot'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person),
            title: Text('Profile'),
            
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        showUnselectedLabels: true,
        unselectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),  
      
      
    );
  }
  final FirebaseAuth _authen = FirebaseAuth.instance;
  void createRecord() async {
    


    final FirebaseUser user = await _authen.currentUser();
    
    final uid = user.uid;
    Firestore.instance.collection('Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      name = DocumentSnapshot.data['Name'].toString(),

);
Firestore.instance.collection('Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      branch = DocumentSnapshot.data['Branch'].toString(),

);
Firestore.instance.collection('Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      college = DocumentSnapshot.data['College'].toString(),

);
Firestore.instance.collection('Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      email = DocumentSnapshot.data['Email'].toString(),

);

    
      
    }
  
}


