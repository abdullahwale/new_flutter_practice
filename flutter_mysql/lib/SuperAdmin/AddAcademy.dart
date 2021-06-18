import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/SuperAdmin/SuperAdminHome.dart';

class AddAcademy extends StatefulWidget {
  @override
  _AddAcademyState createState() => _AddAcademyState();
}

class _AddAcademyState extends State<AddAcademy> {
  TextEditingController _email;
  TextEditingController _pass;
  TextEditingController _name;
  TextEditingController _address;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
    _name = TextEditingController();
    _address = TextEditingController();
  }

  _add() {
    if (_email.text.trim().isEmpty ||
        _pass.text.trim().isEmpty ||
        _name.text.trim().isEmpty ||
        _address.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    Services.addacademy(_name.text, _address.text, _email.text, _pass.text)
        .then((result) {
      if ('success' == result) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SuperHome()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SuperHome()));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Super Admin'),
            backgroundColor: Colors.orange,
          ),
          body: SafeArea(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Academy Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _address,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Academy Address',
                        ),
                      ),
                    ),
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
                    Container(
                        height: 60,
                        padding: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.orangeAccent,
                          child: Text('Add'),
                          onPressed: () {
                            _add();
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
