import 'package:flutter_mysql/Management/CourseManagement/AddCourse.dart';
import 'package:flutter_mysql/Owner/OwnerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class CourseManagementHome extends StatefulWidget {
  String academyName;
  CourseManagementHome({this.academyName});

  @override
  _CourseManagementHomeState createState() => _CourseManagementHomeState();
}

class _CourseManagementHomeState extends State<CourseManagementHome> {
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
          title: Text('Course'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseManagementHome(
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
                future: Services.getCourse(widget.academyName, "All"),
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
                    builder: (context) => AddCourse(
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
              list[i]['class'],
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
              textAlign: TextAlign.right,
            ),
          );
        });
  }
}
