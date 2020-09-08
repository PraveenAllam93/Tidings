import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsPage extends StatefulWidget {

 final DocumentSnapshot post;
 DetailsPage({this.post});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String EventField = "";
  String likePost = "Like";
  int flag = 0;
  int reportFlag = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text(widget.post.data["Event Name"]),
        centerTitle: true,
        
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          child:Column(
            children: <Widget>[
               Text(
                  'Event Details!',
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
                labelText: 'Event Type : ' + widget.post.data["Event Type"],
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
                labelText:'Field : '+ widget.post.data["Field"],
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
                labelText: 'Venue : ' + widget.post.data["Venue"],
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
          SizedBox(height: 20.0),
          
          TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Month : ' + widget.post.data["Month"],
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
          

          InkWell(
          child: Text(
                  widget.post.data["Web Ref"],
                  style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,color: Colors.blueAccent),
                  
                ),
                onTap: (){
                  launch(widget.post.data["Web Ref"]);
                },
          ),
          SizedBox(height : 20.0),
          
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
                      if(flag == 0){
                        Fluttertoast.showToast(
                          msg: "Post Liked!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                                          
                        flag = 1;
                        
                      setState(() {
                        EventField = widget.post.data["Field"].toString();
                      });
                      createInterstsRecord(EventField);
                      
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: "Already Liked!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );

                      }

                      
                    },
                    
                    
                    color: Colors.green,
                    child: Center(
                      
                      child: Text(
                        
                        likePost,
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
                      if(reportFlag == 0){
                        reportRecord(widget.post.data["doc"]);
                        reportFlag = 1;
                        Fluttertoast.showToast(
                          msg: "Reported!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );

                      
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: "Already Reported!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );

                      }
                      

                     },
                      
                      
                    
                    
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Report',
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
    );
     }

  final FirebaseAuth _authen = FirebaseAuth.instance;
  void createInterstsRecord(fieldInput) async {
    final Firestore _firestore = Firestore.instance;
    Random random = new Random();
    int randomNumber = random.nextInt(9999999);
    
    final FirebaseUser user = await _authen.currentUser();
    final uid = user.uid;

    String doc = uid + randomNumber.toString();
    DocumentReference ref = _firestore.collection('Interests').document(doc);
    return ref.setData({'UID' : uid,
      'Intrests' : fieldInput,
      });
    }

  void reportRecord(id) async {
    final Firestore _firestore = Firestore.instance;
    DocumentReference ref = _firestore.collection('Reports').document(id);
    return ref.setData({
      'UID' : widget.post.data["UID"],
      'doc' : widget.post.data["doc"],
      'ClubName' : widget.post.data["ClubName"],
      'Event Name' : widget.post.data["Event Name"],
      'Field' : widget.post.data["Field"],
      'Event Type' : widget.post.data["Event Type"],
      'Description' : widget.post.data["Description"],
      'Web Ref' : widget.post.data["Web Ref"],
      'Venue' : widget.post.data["Venue"],
      'Month' : widget.post.data["Month"],
      });
    }


  } 


