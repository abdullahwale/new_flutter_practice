import 'package:flutter_mysql/Management/CourseManagement/CourseManagement.dart';
import 'package:flutter_mysql/Management/ManagerManagement/ManagerManagement.dart';
import 'package:flutter_mysql/Owner/OwnerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AddManager extends StatefulWidget {
  String academy;
  AddManager({this.academy});
  @override
  _AddManagerState createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  TextEditingController _email;
  TextEditingController _pass;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  _add() {
    if (_email.text.trim().isEmpty || _pass.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    Services.addManager(_email.text, _pass.text, "manager", widget.academy)
        .then((result) {
      if ('success' == result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ManagerManagementHome(
                      academyName: widget.academy,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OwnerHome(
                      academy: widget.academy,
                    )));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Manager'),
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
