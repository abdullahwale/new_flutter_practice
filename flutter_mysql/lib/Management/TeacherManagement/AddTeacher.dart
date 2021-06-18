import 'package:flutter/material.dart';
import 'package:flutter_mysql/Management/TeacherManagement/TeacherManagement.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AddTeacher extends StatefulWidget {
  String academy;
  AddTeacher({this.academy});
  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  TextEditingController _name;
  TextEditingController _subject;
  TextEditingController _email;
  TextEditingController _pass;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _subject = TextEditingController();
    _email = TextEditingController();
    _pass = TextEditingController();
  }

  _add() {
    if (_email.text.trim().isEmpty ||
        _pass.text.trim().isEmpty ||
        _name.text.trim().isEmpty ||
        _subject.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    Services.addManager(_email.text, _pass.text, "teacher", widget.academy)
        .then((result) {
      if ('success' == result) {}
    });
    Services.addTeacher(_name.text, _subject.text, widget.academy)
        .then((result) {
      if ('success' == result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TeacherManagementHome(
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
                builder: (context) => TeacherManagementHome(
                      academyName: widget.academy,
                    )));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Teacher'),
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
                          labelText: 'Teacher Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _subject,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Subject',
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
