import 'package:flutter_mysql/Shared/Background.dart';
import 'package:flutter_mysql/SuperAdmin/SuperAdminHome.dart';
import 'package:flutter/material.dart';

class ModifyAcademy extends StatefulWidget {
  List academyList;
  int index;
  //ModifyAcademy({this.academyName})
  ModifyAcademy({this.academyList, this.index});

  @override
  _ModifyAcademyState createState() => _ModifyAcademyState();
}

class _ModifyAcademyState extends State<ModifyAcademy> {
  String name;

  TextEditingController _city;
  TextEditingController _name;
  TextEditingController _address;

  @override
  void initState() {
    super.initState();
    //name=widget.academyName.academyname;
    _city =
        TextEditingController(text: widget.academyList[widget.index]['city']);
    _name = TextEditingController(
        text: widget.academyList[widget.index]['academy_name']);
    _address = TextEditingController(
        text: widget.academyList[widget.index]['academy_address']);
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
        body: Stack(
          children: <Widget>[
            Background(),
            SafeArea(
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          controller: _city,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City',
                          ),
                        ),
                      ),
                      Container(
                          height: 60,
                          padding: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.orangeAccent,
                            child: Text('Update'),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuperHome()));
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ModifyAcademy()));
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.delete),
        ),
      ),
    );
  }
}
