import 'package:flutter_mysql/Management/SudentManagement/StudentManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AddStudent extends StatefulWidget {
  double hori = 30;
  double verti = 1;

  String academy;
  AddStudent({this.academy});
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController _roll;
  TextEditingController _name;
  TextEditingController _class;
  TextEditingController _address;
  TextEditingController _phone;

  @override
  void initState() {
    super.initState();
    _roll = TextEditingController();
    _name = TextEditingController();
    _class = TextEditingController();
    _address = TextEditingController();
    _phone = TextEditingController();
  }

  _add() {
    if (_roll.text.trim().isEmpty ||
        _name.text.trim().isEmpty ||
        _class.text.trim().isEmpty ||
        _address.text.trim().isEmpty ||
        _phone.text.trim().isEmpty) {
      print("Empty fields");
      return false;
    }
    Services.addStudent(_roll.text, _name.text, _class.text, _address.text,
            _phone.text, widget.academy)
        .then((result) {
      if ('success' == result) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StudentManagementHome(
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
                builder: (context) => StudentManagementHome(
                      academyName: widget.academy,
                    )));
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Student'),
            backgroundColor: Colors.orange,
          ),
          body: SafeArea(
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _roll,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Roll No',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: TextField(
                          controller: _name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Student Name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: TextField(
                          controller: _class,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Class',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: TextField(
                          controller: _address,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(
                            vertical: widget.verti, horizontal: widget.hori),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.orangeAccent,
                          child: Text('Add'),
                          onPressed: () {
                            _add();
                          },
                        )),
                    Expanded(
                      child: Container(
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
