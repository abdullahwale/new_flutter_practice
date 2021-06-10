import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthentication
    show User;
import 'package:flutter/material.dart';
import 'package:new_firebase_expence_app/pages/auth/authWrapper.dart';
import 'package:new_firebase_expence_app/pages/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic _user = Provider.of<FirebaseAuthentication.User>(context);

    if (_user != null && _user.emailVerified) {
      return Home(user: _user);
    } else {
      return AuthWrapper();
    }
  }
}
