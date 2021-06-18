import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/Services/Users.dart';
import 'package:flutter_mysql/SuperAdmin/SuperAdminHome.dart';
import 'package:flutter_mysql/Shared/Background.dart';
import 'package:flutter_mysql/Shared/Loading.dart';
import 'package:flutter_mysql/Shared/Constants.dart';

class SuperAdminLogin extends StatefulWidget {
  final String title = "Login";
  @override
  _SuperAdminLoginState createState() => _SuperAdminLoginState();
}

class _SuperAdminLoginState extends State<SuperAdminLogin> {
  bool loading = false;
  String error = "";
  List<User> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  User _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;
  TextEditingController _email;

  TextEditingController _pass;

  String msg = '';

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  bool _login() {
    if (_email.text.trim().isEmpty || _pass.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    _showProgress('Loading');
    Services.login(_email.text, _pass.text, "super").then((users) {
      _showProgress(widget.title);
      print("Length: ${users.length}");
      print(users);
      if (users.length == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SuperHome()));
        return true;
      }
    });
    return false;
  }

  _showProgress(String message) {}

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
                title: Text('Super Admin'),
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
