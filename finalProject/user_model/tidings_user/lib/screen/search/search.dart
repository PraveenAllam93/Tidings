import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/models/ListPage.dart';
import 'package:tidings_user/screen/Bot/bot.dart';
import 'package:tidings_user/screen/Profile/profilePage.dart';
import 'package:tidings_user/screen/home/home.dart';
import 'package:tidings_user/screen/search/searchhome.dart';
import 'package:tidings_user/service/auth.dart';

class Search extends StatefulWidget {
  
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

    List<AlgoliaObjectSnapshot> _results = [];
    bool _searching = false;
    final _event= TextEditingController();
    bool _eventvalidate = false;
    String event;
  
  String dropdownValue = "January";
  //String eventDropdownValue = "Machine Learing";

  int _selectedIndex = 0;
    AuthService _auth = new AuthService();
  

  String name;
  String branch;
  String college;
  String email;
  
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
    setState(() {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Home()));
        Navigator.of(context)
        .popUntil(ModalRoute.withName('/'));
        
        _selectedIndex = index;
      });
      
    }
    
    if(index == 1){
      Fluttertoast.showToast(
        msg: "You're in search!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
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
  
    void dispose() {
    _event.dispose();
    super.dispose();
    }
   
  Widget build(BuildContext context) {
    createProRecord();
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts!'),
        centerTitle: true,

        backgroundColor: Colors.green,
        elevation: 20.0,
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          
          child:Column(
            children: <Widget>[
                Text(
                  'Find your Events!',
                  style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.amber[800])
                ),
              SizedBox(height: 20.0),

      //         DropdownButton<String>(
      //           value: eventDropdownValue,
                
      //           onChanged: (val) {
                
      //             setState(() => eventDropdownValue = val);
                  
      //           },
                
                
      //           isExpanded: true,
      //           icon: Icon(Icons.arrow_downward),
      //           iconSize: 24,
      //           elevation: 16,
      //           style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
      //           underline: Container(
      //             height: 2,
      //             color: Colors.grey[300],
      //           ),
      //           items: <String>['Machine Learning' , ' Artificial Intelligence', 'Big Data', 'IOT', 'Cloud Computing','AWS','Flutter','Android']
      //             .map<DropdownMenuItem<String>>((String value) {
      //           return DropdownMenuItem<String>(
      //             value: value,
      //             child: Text(value),
      //           );
      // }).toList(),
                          
                   
      //         ),
              
      //         SizedBox(height: 20.0),
              TextField(
                controller: _event,
                onChanged: (val) {
                  setState(() => event = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: "Enter the field Of event.",
                errorText: _eventvalidate ? 'Please enter field' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              
              SizedBox(height: 30.0),
              DropdownButton<String>(
                value: dropdownValue,
                
                onChanged: (val) {
                
                  setState(() => dropdownValue = val);
                  
                },
                
                
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                underline: Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
                items: <String>['January', 'Febraury', 'March', 'April','May','June','July','August','September','October','November','December']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
      }).toList(),
                          
                   
              ),
              
              SizedBox(height: 30.0),
              Container(
                height: 40.0,
                child: Material(
                  shadowColor: Colors.greenAccent,
                  elevation: 0.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                       side: BorderSide(color:Colors.green),
                    

                    ),

                  
                    onPressed: () async{
                            Fluttertoast.showToast(
                              msg: "Searching....!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );

                          Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchHome(event : event , month: dropdownValue)));
        
                          
                            

                          

                        
                    },
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Search.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',


                        ),


                      ),
                    ),
              ),
              
          ),
              
          
              ),   
          
              
              
            ]
        )
        

      ),
      
      
      ), 
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
    final Firestore _firestore = Firestore.instance;
  
    
    final FirebaseUser user = await _authen.currentUser();
    
    final uid = user.uid;
    
    }

  
  void createProRecord() async {
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