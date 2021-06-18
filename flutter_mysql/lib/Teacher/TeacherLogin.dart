import 'package:flutter_mysql/Shared/Background.dart';
import 'package:flutter_mysql/Teacher/TeacherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Shared/Loading.dart';
import 'package:flutter_mysql/Shared/Constants.dart';
import 'package:flutter_mysql/Services/Services.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key key}) : super(key: key);

  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  bool loading = false;
  String error = "";
  TextEditingController _email;

  TextEditingController _pass;

  String msg = '';

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  bool _login() {
    if (_email.text.trim().isEmpty || _pass.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }

    Services.login(_email.text, _pass.text, "teacher").then((users) {
      print("Length: ${users.length}");
      print(users);
      if (users.length == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TeacherHome()));
        return true;
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                title: Text('Teacher'),
                backgroundColor: Colors.orange,
              ),
              body: Stack(
                children: <Widget>[
                  Background(),
                  SafeArea(
                    child: Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: _email,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'User Name'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextField(
                                obscureText: true,
                                controller: _pass,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              textColor: Colors.orangeAccent,
                              child: Text('Forgot Password'),
                            ),
                            Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.orangeAccent,
                                child: Text('Login'),
                                onPressed: () {
                                  error = "";
                                  setState(() => loading = true);
                                  if (_login()) {
                                    loading = false;
                                  } else {
                                    error = "invailed credential";
                                    loading = false;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
