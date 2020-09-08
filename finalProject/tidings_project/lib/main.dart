import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tidings_project/models/user.dart';
import 'package:tidings_project/service/auth.dart';
import 'package:tidings_project/wrapper.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );

  }
}

