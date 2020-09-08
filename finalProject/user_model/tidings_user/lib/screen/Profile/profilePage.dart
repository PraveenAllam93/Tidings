import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/screen/Bot/bot.dart';
import 'package:tidings_user/screen/home/home.dart';
import 'package:tidings_user/screen/search/search.dart';

import 'editProfile.dart';

class Profilepage extends StatefulWidget {
  final String name,email,branch,college;
 Profilepage({this.name,this.email,this.branch,this.college});
  @override

  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  int _selectedIndex = 0;
  
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  
  

  
  void _onItemTapped(int index) {
    
    if(index == 1){
      Fluttertoast.showToast(
        msg: "You're in Recommendations!",
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
        msg: "You're in Profile Page!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
      
    }
    if(index == 0){
      Fluttertoast.showToast(
        msg: "Home!",
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
  }

               
  
  @override

  Widget build(BuildContext context) {
    
        return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text('Tidings!'),
                
        centerTitle: true,
      ),
    
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          child:Column(
            children: <Widget>[
              
               Text(
                  'Profile!',
                  style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold,color: Colors.amber[800]),
                ),
          
          SizedBox(height : 20.0),
          TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: "Name : " + widget.name,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    ),
                ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 20.0,
            ),
          ),
           SizedBox(height : 20.0),
          
          
          TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText:"Branch : " + widget.branch,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    ),
                ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 20.0,
            ),
          ),
          SizedBox(height : 20.0),
          
          TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText:"Email : " + widget.email,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    ),
                ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 30.0),
          TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: "College : " + widget.college,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                    ),
                ),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 20.0,
            ),
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
                          msg: "Edit Your Profile Data!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditProfile(name: widget.name,email: widget.email,branch: widget.branch,college: widget.college,)));
        
                      

                     },
                      
                      
                    
                    
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Edit Profile.',
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
      )
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

                   
}