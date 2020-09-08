import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tidings_user/models/user.dart';
import 'package:tidings_user/service/auth.dart';
import 'package:tidings_user/wrapper.dart';
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

