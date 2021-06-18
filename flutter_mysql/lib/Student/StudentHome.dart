import 'package:flutter_mysql/Student/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Shared/Background.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'AcademyDetail.dart';
import 'package:flutter_mysql/Services/Academy.dart';
import 'package:flutter_mysql/Services/Services.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String name;
  String countryname, message;
  bool error;
  var data;
  bool isLoading = true;
  CourseDetail obj;
  List<String> cities = ["Mailsi", "Vehari"];
  List<String> list = ["Select city"];

  @override
  void initState() {
    error = false;
    message = "";
    super.initState();
  }

  void getCity(String city) {
    Services.getAcademy(city).then((academylist) {
      print("Length: ${academylist.length}");
      print(academylist);
      list = ["Chose Academy"];
      for (int i = 0; i < academylist.length; i++) {
        list.add(academylist[i].academyname);
      }
    });
  }

  int _value = 1;
  String address;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Student'),
          backgroundColor: Colors.orange,
        ),
        body: Stack(
          children: <Widget>[
            Background(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: DropdownButton(
                          hint: Text(
                            "Select City",
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          isExpanded: true,
                          items: cities.map((city) {
                            return DropdownMenuItem(
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              value: city,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              getCity(value);
                              print("Selected city is $value");
                            });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: DropdownButton(
                          hint: Text(
                            "Select Academy",
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          isExpanded: true,
                          items: list.map((city) {
                            return DropdownMenuItem(
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              value: city,
                            );
                          }).toList(),
                          onChanged: (value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AcademyDetail(
                                          AcademyName: value,
                                        )));
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
body: Stack(
children: <Widget>[
Background(),
SafeArea(

),
],
),
*/
