import 'package:flutter_mysql/Owner/OwnerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Services/Services.dart';

class OwnerLogin extends StatefulWidget {
  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  String academyName;
  TextEditingController _email;
  TextEditingController _pass;

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

    Services.login(_email.text, _pass.text, "owner").then((users) {
      print("Length: ${users.length}");
      print(users);
      if (users.length == 1) {
        academyName = users[0].academyname;
        print(users[0].academyname);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OwnerHome(
                      academy: academyName,
                    )));
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
      child: Scaffold(
          appBar: AppBar(
            title: Text('Owner'),
            backgroundColor: Colors.orange,
          ),
          body: SafeArea(
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
                              fontSize: 30),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: _pass,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
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
                            _login();
                          },
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
