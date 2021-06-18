import 'package:flutter_mysql/Management/CourseManagement/CourseManagement.dart';
import 'package:flutter_mysql/Management/FeeManagement/FeeManagement.dart';
import 'package:flutter_mysql/Management/ManagerManagement/ManagerManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Management/SudentManagement/StudentManagement.dart';
import 'package:flutter_mysql/Management/TeacherManagement/TeacherManagement.dart';

// ignore: must_be_immutable
class OwnerHome extends StatelessWidget {
  String academy;
  OwnerHome({this.academy});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Management Home'),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
              width: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print(academy);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherManagementHome(
                                  academyName: academy,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 130.0,
                    width: 130.0,
                    color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.work_outline,
                          size: 50.0,
                        ),
                        Text(
                          'Teachers',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  width: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    print(academy);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentManagementHome(
                                  academyName: academy,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 130.0,
                    width: 130.0,
                    color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.school,
                          size: 50.0,
                        ),
                        Text(
                          'Student',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
              width: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print(academy);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeeManagementHome(
                                  academyName: academy,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 130.0,
                    width: 130.0,
                    color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wallet_membership,
                          size: 50.0,
                        ),
                        Text(
                          'Fee',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  width: 40.0,
                ),
                GestureDetector(
                  onTap: () {
                    print(academy);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseManagementHome(
                                  academyName: academy,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 130.0,
                    width: 130.0,
                    color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.app_registration,
                          size: 50.0,
                        ),
                        Text(
                          'Course',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
              width: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print(academy);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerManagementHome(
                                  academyName: academy,
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 130.0,
                    width: 130.0,
                    color: Colors.orange,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.account_box_outlined,
                          size: 50.0,
                        ),
                        Text(
                          'Manager',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
