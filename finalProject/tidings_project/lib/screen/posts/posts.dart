
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_project/screen/Bot/bot.dart';
import 'package:tidings_project/screen/Profile/profilePage.dart';
import 'package:tidings_project/screen/home/home.dart';
import 'package:tidings_project/service/auth.dart';

class Posts extends StatefulWidget {
  
  final DateTime initialDateTime;

  const Posts({Key key, this.initialDateTime}) : super(key: key);
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {

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
        msg: "Home Page!",
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
        _selectedIndex = index;
        Navigator.of(context)
        .popUntil(ModalRoute.withName('/'));
        
            });
        
      
    }
    
    if(index == 1){
      Fluttertoast.showToast(
        msg: "You are in Posts!",
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

  
  final _fromkey = GlobalKey<FormState>();
  final _clubname = TextEditingController();
  final _eventType = TextEditingController();
  final _description = TextEditingController();
  final _weblink = TextEditingController();
  final _venue = TextEditingController();
  final _field = TextEditingController();
  final _eventname = TextEditingController();
  
  bool _namevalidate = false, _eventvalidate = false,_desvalidate = false,_webvalidate = false,_venuevalidate = false,_fieldValidate = false, _eventnameValidate = false;
  String clubname = "", eventType = "", description = "", weblink = "",error = "",venue = "",field="",eventname = "";

    
  String dropdownValue = "January";
  
  @override
   void initState() {
     super.initState();
   }
   void dispose() {
    _clubname.dispose();
    _field.dispose();
    _eventType.dispose();
    _description.dispose();
    _eventname.dispose();
    _weblink.dispose();
    _venue.dispose();
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
        key: _fromkey,
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          
          child:Column(
            children: <Widget>[
                Text(
                  'Event, Woah!',
                  style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.amber[800])
                ),
              SizedBox(height: 20.0),
              TextField(
                controller: _clubname,
                onChanged: (val) {
                  setState(() => clubname = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Club Name',
                errorText: _namevalidate ? 'Please enter Club Name/ Organiser name' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _eventname,
                onChanged: (val) {
                  setState(() => eventname = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Event Name',
                errorText: _eventnameValidate ? 'Please enter the name of Event' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              
              TextField(
                controller: _eventType,
                onChanged: (val) {
                  setState(() => eventType= val);
                },
                decoration: InputDecoration(
                  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Event type',
                errorText: _eventvalidate ? 'Please do mention the kindof Event.' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              
              SizedBox(height: 20.0),
              TextField(
                minLines: 1,
                maxLines: 4,
                controller: _description,
                onChanged: (val) {
                  setState(() => description = val);
                },
                decoration: InputDecoration(
                  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Description',
                errorText: _desvalidate ? 'Please do give a discription' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              TextField(
                autofocus: true,
                controller: _field,
                onChanged: (val) {
                  setState(() => field = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Field Of Event',
                errorText: _fieldValidate ? 'Please give a valid Field' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              
              TextField(
                autofocus: true,
                controller: _weblink,
                onChanged: (val) {
                  setState(() => weblink = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Web Link',
                errorText: _webvalidate ? 'Please give a web link' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _venue,
                onChanged: (val) {
                  setState(() => venue = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Venue',
                errorText: _venuevalidate ? 'Please enter a Venue' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              // DateTimeFormField(
              //   initialValue: widget.initialDateTime,
              //   label: 'Start Date of the Event!',
              //   validator: (DateTime dateTime) {
              //     if (dateTime == null) {
              //       return "Date Time Required";
              //     }
              //     return null;
              //   },
              //   onSaved: (DateTime dateTime) => _startDate = dateTime,
                

              // ),
              // DateTimeFormField(
              //   initialValue: widget.initialDateTime,
              //   label: 'End Date of the Event!',
                
              //   validator: (DateTime dateTime) {
              //     if (dateTime == null) {
              //       return "Date Time Required";
                
              //     }
              //     return null;
              //   },
              //   onSaved: (DateTime dateTime) => _endDate = dateTime
              
              // ),
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
              
              SizedBox(height: 20.0),
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
                      setState(() {
                        _eventname.text.isEmpty ? _eventnameValidate = true : _eventnameValidate = false;
                        _field.text.isEmpty ? _fieldValidate = true : _fieldValidate = false;
                        _clubname.text.isEmpty ? _namevalidate = true : _namevalidate = false;
                        _eventType.text.isEmpty ? _eventvalidate = true : _eventvalidate = false;
                        _description.text.isEmpty ? _desvalidate = true : _desvalidate = false;
                        _weblink.text.isEmpty ? _webvalidate = true : _webvalidate = false;
                        _venue.text.isEmpty ? _venuevalidate = true : _venuevalidate = false;
                        
                      });
                        if(_namevalidate == false && _eventnameValidate == false &&_eventvalidate == false &&_desvalidate == false &&_webvalidate == false && _venuevalidate == false && _fieldValidate == false){
                          
                            createRecord();
                            Navigator.of(context)
        .popUntil(ModalRoute.withName('/'));
        
                            Fluttertoast.showToast(
                              msg: "Event Posted Successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                            _field.text = "";
                            _eventname.text = "";
                            _clubname.text = "";
                            _eventType.text = "";
                            _description.text = "";
                            _weblink.text = "";
                            _venue.text = "";
                            

                          

                        }
                    },
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Post',
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
            icon: Icon(Icons.add),
            title: Text('Add Post'),
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
    Random random = new Random();
    int randomNumber = random.nextInt(9999999);
    String doc = clubname + randomNumber.toString();
    
    final FirebaseUser user = await _authen.currentUser();
    
    final uid = user.uid;
    DocumentReference ref = _firestore.collection('Posts').document(doc);
    return ref.setData({'UID' : uid,
      'doc' : doc,
      'ClubName' : clubname,
      'Event Name' : eventname,
      'Field' : field,
      'Event Type' : eventType,
      'Description' : description,
      'Web Ref' : weblink,
      'Venue' : venue,
      'Month' : dropdownValue,
      
      });
    }

  void createProRecord() async {
    


    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    
    final uid = user.uid;
    Firestore.instance.collection('Club Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      name = DocumentSnapshot.data['Name'].toString(),

);
Firestore.instance.collection('Club Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      branch = DocumentSnapshot.data['Branch'].toString(),

);
Firestore.instance.collection('Club Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      college = DocumentSnapshot.data['College'].toString(),

);
Firestore.instance.collection('Club Profile').document(uid)
      .get().then((DocumentSnapshot) =>
      email = DocumentSnapshot.data['Email'].toString(),

);

    
      
    }
}