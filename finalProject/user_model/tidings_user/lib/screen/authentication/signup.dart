import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/service/auth.dart';
import 'package:tidings_user/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = new AuthService();
  final databaseReference = Firestore.instance;
  final _fromkey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pssd = TextEditingController();
  final _cpssd = TextEditingController();
  final _branch = TextEditingController();
  final _clg = TextEditingController();
  bool _namevalidate = false, _emailvalidate = false,_pssdvalidate = false,_cpssdvalidate = false,loading = false,_clgvalidate = false, _branchvalidate = false;
  String name = "", email = "", pssd = "", cpssd = "",error = "",branch = "", clg = "";
  @override

  void dispose() {
    _name.dispose();
    _email.dispose();
    _pssd.dispose();
    _cpssd.dispose();
    _branch.dispose();
    _clg.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text('SignUp to TIDINGS!'),
        centerTitle: true,
        
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          key: _fromkey,
          child:Column(
            children: <Widget>[
              Text(
                  'Hello, Woah!',
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
                labelText: 'Name',
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
                controller: _email,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Email',
                errorText: _emailvalidate ? 'Please enter Email' : null,
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
                errorText: _branchvalidate ? 'Please enter Branch' : null,
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
                controller: _pssd,
                obscureText: true,
                onChanged: (val) {
                  setState(() => pssd = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Password',
                errorText: _pssdvalidate ? 'Please enter Password >6' : null,
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
                controller: _cpssd,
                obscureText: true,
                onChanged: (val) {
                  setState(() => cpssd = val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Confirm Password',
                errorText: (pssd != cpssd) ? 'Confirm Password must be equal to Password' : null,
                
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
                  setState(() => clg= val);
                },
                decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'College',
                errorText: _pssdvalidate ? 'Please enter College Name' : null,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                    ),
                ),   
              ),
              
              SizedBox(height:20.0),
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
                        _email.text.isEmpty ? _emailvalidate = true : _emailvalidate = false;
                        _pssd.text.isEmpty ? _pssdvalidate = true : _pssdvalidate = false;
                        _cpssd.text.isEmpty ? _cpssdvalidate = true : _cpssdvalidate = false;
                        _clg.text.isEmpty ? _clgvalidate = true : _clgvalidate = false;
                        _branch.text.isEmpty ? _branchvalidate = true : _branchvalidate = false;
                        
                        
                      });
                      if(pssd == cpssd){
                        if(_namevalidate == false && _emailvalidate == false &&_pssdvalidate == false &&_cpssdvalidate == false && _branchvalidate == false && _clgvalidate == false){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailAndPassword(email, pssd);
                          if(result == null){
                            setState(() {
                              loading = false;
                              error = 'Please use valid email';
                              Fluttertoast.showToast(
                                  msg: "Failed, Please use a valid email!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0
                              );
                            });
                          }
                          else{
                            createRecord();
                            Fluttertoast.showToast(
                                msg: "Acoount Created Successfully!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }

                        }
                      }

                    },
                    
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Register',
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
          
          SizedBox(height: 40.0),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already have an account ?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            widget.toggleView();
          },
          child: Text('LogIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.green,
            decoration: TextDecoration.underline,
            ),
          ),
        )

      ],
    )

            ],
          ) ,
        ),
      ),
      
    );
  }

  final FirebaseAuth _authen = FirebaseAuth.instance;
  void createRecord() async {
    final Firestore _firestore = Firestore.instance;
    
    final FirebaseUser user = await _authen.currentUser();
    
    final uid = user.uid;
    DocumentReference ref = _firestore.collection('Profile').document(uid);
    return ref.setData({'UID' : uid,
      'Name' : name,
      'Email' : email,
      'Password' : pssd,
      'Branch' : branch,
      'College' : clg
      });
    }
}