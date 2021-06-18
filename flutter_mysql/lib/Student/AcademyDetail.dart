import 'package:flutter_mysql/Student/AcademyInfo.dart';
import 'package:flutter_mysql/Student/CourseDetail.dart';
import 'package:flutter_mysql/Student/StudentHome.dart';
import 'package:flutter_mysql/Student/TeacherDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Background.dart';

class AcademyDetail extends StatefulWidget {
  String AcademyName;
  AcademyDetail({this.AcademyName});
  @override
  _AcademyDetailState createState() => _AcademyDetailState();
}

class _AcademyDetailState extends State<AcademyDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StudentHome()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.AcademyName),
          backgroundColor: Colors.orange,
        ),
        body: Stack(
          children: <Widget>[
            Background(),
            SafeArea(
              child: Tabs(
                AcademyName: widget.AcademyName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  String AcademyName;
  Tabs({this.AcademyName});
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.orange,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Information',
                          ),
                          Tab(text: 'Teacher'),
                          Tab(text: 'Course'),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height -
                            136, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          AcademyInfo(
                            AcademyName: widget.AcademyName,
                          ),
                          TeacherDetail(
                            AcademyName: widget.AcademyName,
                          ),
                          CourseDetail(
                            AcademyName: widget.AcademyName,
                          ),
                        ]))
                  ])),
        ],
      ),
    );
  }
}
