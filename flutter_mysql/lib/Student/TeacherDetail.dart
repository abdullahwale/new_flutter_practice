import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class TeacherDetail extends StatefulWidget {
  String AcademyName;
  TeacherDetail({this.AcademyName});

  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder<List>(
          future: Services.getTeachers(widget.AcademyName),
          builder: (ctx, ss) {
            if (ss.hasError) {
              print("Error");
            }
            if (ss.hasData) {
              return TeacherItem(list: ss.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class TeacherItem extends StatelessWidget {
  List list;
  TeacherItem({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return Card(
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[i]['teacher_name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            list[i]['subject'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
