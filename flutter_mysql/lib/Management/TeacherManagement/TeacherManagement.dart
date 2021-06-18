import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/Management/TeacherManagement/AddTeacher.dart';
import 'package:flutter_mysql/Owner/OwnerHome.dart';

class TeacherManagementHome extends StatefulWidget {
  String academyName;
  TeacherManagementHome({this.academyName});
  @override
  _TeacherManagementHomeState createState() => _TeacherManagementHomeState();
}

class _TeacherManagementHomeState extends State<TeacherManagementHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OwnerHome(
                      academy: widget.academyName,
                    )));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teacher List'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherManagementHome(
                              academyName: widget.academyName,
                            )));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Center(
              child: FutureBuilder<List>(
                future: Services.getTeachers(widget.academyName),
                builder: (ctx, ss) {
                  if (ss.hasError) {
                    print("Error");
                  }
                  if (ss.hasData) {
                    return Items(list: ss.data);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTeacher(
                          academy: widget.academyName,
                        )));
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;
  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(
              list[i]['teacher_name'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              list[i]['subject'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          );
        });
  }
}
