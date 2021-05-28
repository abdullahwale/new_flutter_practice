import 'package:flutter/material.dart';
import 'package:tiktokdemo/variable.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? Login() : HomePage(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to TiKTokClone",
              style: mystyle(30, Colors.black, FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "LogIn",
              style: mystyle(20, Colors.black, FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        labelStyle: mystyle(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))))),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        labelStyle: mystyle(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))))),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              // margin: EdgeInsets.only(left: 20, right: 20),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20)), // BoxDecoration
              child: Center(
                child: Text("Login",
                    style: mystyle(20, Colors.white, FontWeight.w700)),
              ), // Center
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              //navigation dart-tiktok-Visual Studio Code
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: mystyle(20),
                ),
                // Text
                SizedBox(
                  width: 10,
                ),
                //
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Register",
                  style: mystyle(20, Colors.purple),
                ) //

                // Text
              ],
            ) //Row// Container
          ],
        ),
      ),
    );
  }
}
