import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktokdemo/policy.dart';

import 'variable.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController userControler = TextEditingController();
  registerUser() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailControler.text, password: passwordControler.text)
        .then((signedUser) => {
              userCollection.doc(signedUser.user.uid).set({
                'userName': userControler.text,
                'password': passwordControler.text,
                'email': emailControler.text,
                'uid': signedUser.user.uid,
                'profilepic':
                    'https://en.wikipedia.org/wiki/File:Blue_Unknot.png'
              })
            });
    Navigator.pop(context);
  }

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
              "Sign-Up page",
              style: mystyle(30, Colors.black, FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Sign-UP",
              style: mystyle(20, Colors.black, FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    controller: emailControler,
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
                    controller: userControler,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'UserName',
                        prefixIcon: Icon(Icons.person),
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
                    controller: passwordControler,
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
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Repeat Password',
                        prefixIcon: Icon(Icons.lock),
                        labelStyle: mystyle(20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))))),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => registerUser(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                // margin: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)), // BoxDecoration
                child: Center(
                  child: Text("Register or SignUp",
                      style: mystyle(20, Colors.white, FontWeight.w700)),
                ), // Center
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              //navigation dart-tiktok-Visual Studio Code
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I have read and agree",
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
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Terms())),
                  child: Text(
                    "All Conditions",
                    style: mystyle(20, Colors.purple),
                  ),
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
