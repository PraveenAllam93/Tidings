import 'package:firebase_auth/firebase_auth.dart';
import 'package:tidings_user/models/profile.dart';
import 'package:tidings_user/models/user.dart';


class AuthService {
  final Profile profile;
  AuthService({this.profile});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on firebase object
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
  
  // uid
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  Future getCurrentUser() async {
    return await _auth.currentUser();
  }
  
  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
       .map((FirebaseUser user) => _userFromFirebaseUser(user)); // == map(_userFromFirebaseUser)
  }

  //sign in anonomusly.
  Future signInAnon() async {
    try {
     AuthResult result =  await _auth.signInAnonymously();
     FirebaseUser user = result.user;
     return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign in with eamil and password.
  Future signInWithEmailAndPassword(String emial, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: emial, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
      }
    }

  // register with email and password.
  Future registerWithEmailAndPassword(String emial, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: emial, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid.



      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
      }
    }
  

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
      }
  }

}