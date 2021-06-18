import 'package:flutter_mysql/Owner/OwnerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/Management/SudentManagement/AddStudent.dart';

class StudentManagementHome extends StatefulWidget {
  String academyName;
  StudentManagementHome({this.academyName});
  @override
  _StudentManagementHomeState createState() => _StudentManagementHomeState();
}

class _StudentManagementHomeState extends State<StudentManagementHome> {
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
          title: Text('Student List'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentManagementHome(
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
                future: Services.getStudents(widget.academyName),
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
                    builder: (context) => AddStudent(
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
              list[i]['student_name'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              list[i]['class'] + " " + list[i]['address'],
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
