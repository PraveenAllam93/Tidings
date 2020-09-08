import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tidings_project/models/user.dart';
import 'package:tidings_project/screen/authentication/authentication.dart';
import 'package:tidings_project/screen/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either home page or authenticate widget.
    if(user == null){ return Authenticate(); }
    else {return Home(); }
  }
}