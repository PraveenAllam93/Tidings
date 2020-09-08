import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/screen/home/home.dart';

class EditProfile extends StatefulWidget {
  final String name,email,branch,college;
 EditProfile({this.name,this.email,this.branch,this.college});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final databaseReference = Firestore.instance;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _branch = TextEditingController();
  final _clg = TextEditingController();
  bool _namevalidate = false, _branchValidate = false,_clgValidate = false;
  String name = "",error = "",branch = "", clg = "";
  @override

  void dispose() {
    _name.dispose();
    _branch.dispose();
    _clg.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text('Profile!'),
                
        centerTitle: true,
      ),
    
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          child:Column(
            children: <Widget>[
              Text(
                  'Edit Profile!',
                  style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold)
                ),
              SizedBox(height: 20.0),
              
              TextField(
                controller: _name,
                onChanged: (val) {
                  setState(() => name = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: "Name",
                hintText: widget.name ,
                errorText: _namevalidate ? 'Please enter Name' : null,
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
                controller: _branch,
                onChanged: (val) {
                  setState(() => branch = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Branch',
                hintText: widget.branch,
                errorText: _branchValidate? 'Please enter Branch' : null,
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
                controller: _clg,
                onChanged: (val) {
                  setState(() => clg = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'College',
                hintText: widget.college,
                errorText: _clgValidate ? 'Please enter College' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              SizedBox(height: 20.0),
              
          
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
                      setState(() {
                        _name.text.isEmpty ? _namevalidate = true : _namevalidate = false;
                        _clg.text.isEmpty ? _clgValidate = true : _clgValidate = false;
                        _branch.text.isEmpty ? _branchValidate = true : _branchValidate = false;
                        if(_namevalidate == false && _branchValidate == false && _clgValidate == false){
                          updateRecord();
                          Fluttertoast.showToast(
                              msg: "Profile Updated!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                          Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Home()));
        
                          }
                      
                      
                        
                      });
                      
                    
                      

                     },
                      
                      
                    
                    
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Done.',
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
  void updateRecord() async {
    final Firestore _firestore = Firestore.instance;
    
    final FirebaseUser user = await _authen.currentUser();
    
    final uid = user.uid;
    DocumentReference ref = _firestore.collection('Profile').document(uid);
    return ref.updateData({'UID' : uid,
      'Name' : name,
      'Branch' : branch,
      'College' : clg
      });
    }  
}