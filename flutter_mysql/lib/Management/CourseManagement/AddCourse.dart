import 'package:flutter_mysql/Management/CourseManagement/CourseManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AddCourse extends StatefulWidget {
  String academy;
  AddCourse({this.academy});
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController _class;
  TextEditingController _subject;
  @override
  void initState() {
    super.initState();
    _class = TextEditingController();
    _subject = TextEditingController();
  }

  _add() {
    if (_class.text.trim().isEmpty || _subject.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    Services.addCourse(_class.text, _subject.text, widget.academy)
        .then((result) {
      if ('success' == result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CourseManagementHome(
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
                builder: (context) => CourseManagementHome(
                      academyName: widget.academy,
                    )));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Fee'),
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
                        controller: _class,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Class Name',
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
