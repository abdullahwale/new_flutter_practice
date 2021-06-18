import 'package:flutter_mysql/Manager/ManagerLogin.dart';
import 'package:flutter_mysql/Student/StudentHome.dart';
import 'package:flutter/material.dart';
import '../SuperAdmin/SuperAdminLogin.dart';
import '../Teacher/TeacherLogin.dart';
import '../Owner/OwnerLogin.dart';
import 'package:flutter_mysql/Shared/Background.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  double screenHeight;
  double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Background(),
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'Assets/bg_images/header.jpeg',
                  height: 200.0,
                  width: 360,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GotoStudent(),
                SizedBox(
                  height: 100.0,
                  width: 20.0,
                ),
                GotoTeacher(),
              ],
            ),
            SizedBox(
              height: 20.0,
              width: 200.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GotoOwner(),
                SizedBox(
                  height: 100.0,
                  width: 20.0,
                ),
                GotoManager(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GotoSuper(),
              ],
            ),
          ],
        )),
      ],
    ));
  }
}

class GotoSuper extends StatefulWidget {
  @override
  _GotoSuperState createState() => _GotoSuperState();
}

class _GotoSuperState extends State<GotoSuper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SuperAdminLogin()));
        });
      },
      child: Image.asset(
        'Assets/bg_images/super_pannel.jpeg',
        height: 190.0,
        width: 280.0,
      ),
    );
  }
}

class GotoStudent extends StatefulWidget {
  @override
  _GotoStudentState createState() => _GotoStudentState();
}

class _GotoStudentState extends State<GotoStudent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => StudentHome()));
        });
      },
      child: Image.asset(
        'Assets/bg_images/student_pannel.jpeg',
        height: 130.0,
        width: 150.0,
      ),
    );
  }
}

class GotoTeacher extends StatefulWidget {
  @override
  _GotoTeacherState createState() => _GotoTeacherState();
}

class _GotoTeacherState extends State<GotoTeacher> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TeacherLogin()));
        });
      },
      child: Image.asset(
        'Assets/bg_images/teacher_pannel.jpeg',
        height: 130.0,
        width: 150.0,
      ),
    );
  }
}

class GotoOwner extends StatefulWidget {
  @override
  _GotoOwnerState createState() => _GotoOwnerState();
}

class _GotoOwnerState extends State<GotoOwner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OwnerLogin()));
        });
      },
      child: Image.asset(
        'Assets/bg_images/owner_pannel.jpeg',
        height: 130.0,
        width: 150.0,
      ),
    );
  }
}

class GotoManager extends StatefulWidget {
  @override
  _GotoManagerState createState() => _GotoManagerState();
}

class _GotoManagerState extends State<GotoManager> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ManagerLogin()));
        });
      },
      child: Image.asset(
        'Assets/bg_images/manager_pannel.jpeg',
        height: 130.0,
        width: 150.0,
      ),
    );
  }
}
