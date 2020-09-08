
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_user/service/auth.dart';
import 'package:tidings_user/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _fromkey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pssd = TextEditingController();

  bool _emailvalidate = false,_pssdvalidate = false,loading = false;
  final AuthService _auth = AuthService();
  String emailValue = "",passwordValue = "",error = "";
  @override

   void dispose() {
    _email.dispose();
    _pssd.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final email = TextField(
      controller: _email,
      onChanged: (val) => emailValue = val,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          
          labelText: 'EMAIL',
          errorText: _emailvalidate ? 'Email can\'t be Empty!' : null,
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.grey,
              ),
          ),   
      );
    
    final password = TextField(
      controller: _pssd,
      onChanged: (val) => passwordValue = val,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          labelText: 'PASSWORD',
          errorText: _pssdvalidate ? 'Password can\'t be Empty!' : null,
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.grey,
              ),
          ),   
          obscureText: true,
      );
      
    
  return loading ? Loading() : Scaffold(
    backgroundColor: Colors.white,
     appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 20.0,
        title:  Text('LogIn to TIDINGS!'),
        centerTitle: true,
        
      ),
   
    resizeToAvoidBottomPadding: false,
    
    body: SingleChildScrollView(
      key: _fromkey,
      padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
        child: Form(
          child:Column(
          
        
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
              padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
               child:Text(
                  'Hello, There!',
                  style: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold)
                ),
              ),
              
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top:35.0,left:20.0,right:20.0),
          child: Column(
            children: <Widget>[
              email,
              SizedBox(height:30.0),
              password,
              SizedBox(height:10.0),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top:15.0,left:20.0),
                child: InkWell(
                  child: Text('Forgot Password ?',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline,

                  ),
                  ),
                  onTap: (){
                    if(emailValue.isNotEmpty){
                    resetPassword(emailValue);
                    Fluttertoast.showToast(
                        msg: "Check your mail For reset link.",
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
                        msg: "Enter email and click on Forgot Passwrod.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );

                    }
                  },
                ),
              ),
              SizedBox(height:30.0),
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
                        _email.text.isEmpty ? _emailvalidate = true : _emailvalidate = false;
                        _pssd.text.isEmpty ? _pssdvalidate = true : _pssdvalidate = false;
                      });
                      if(_pssdvalidate == false && _emailvalidate == false){
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(emailValue, passwordValue);
                                if(result == null){
                                  setState(() {
                                    loading = false;
                                    error = 'Please use valid email';
                                    
                                      Fluttertoast.showToast(
                                          msg: "Error signing in, check your credentials. If new create Acoount!",
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
                                  Fluttertoast.showToast(
                                      msg: "Signing into Tidings!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                  print("User Signed in");
                                  print(result);
                  }
                            }
                    },
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'LogIn',
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
                          loading = true;
                        });    
                        dynamic result = await _auth.signInAnon();
                  if(result == null){
                    setState(() {
                      loading = false;
                    });
                    
                    print("Error signing in");
                  }else{
                    Fluttertoast.showToast(
                        msg: "Signing Anonomously!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                    print("User Signed in");
                    print(result);
                  }
              },
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'SignIn Anonomously',
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
                'New User ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  widget.toggleView();
                  
                    Fluttertoast.showToast(
                        msg: "Create an Acoount!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                },
                child: Text('Register',
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
        
        ],)
        
      ),
        
      ],
          ))
    ),
        
    );
  }
  Future<void> resetPassword(String email) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
    await _firebaseAuth.sendPasswordResetEmail(email: email);
}
  }