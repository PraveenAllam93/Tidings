import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tidings_user/screen/authentication/authentication.dart';
import 'package:tidings_user/screen/home/home.dart';

import 'models/user.dart';

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