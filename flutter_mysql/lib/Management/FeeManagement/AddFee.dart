import 'package:flutter_mysql/Management/FeeManagement/FeeManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AddFee extends StatefulWidget {
  String academy;
  AddFee({this.academy});
  @override
  _AddFeeState createState() => _AddFeeState();
}

class _AddFeeState extends State<AddFee> {
  TextEditingController _name;
  TextEditingController _subject;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _subject = TextEditingController();
  }

  _add() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FeeManagementHome(
                  academyName: widget.academy,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FeeManagementHome(
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
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Student Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _subject,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Class',
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
