import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class CourseDetail extends StatefulWidget {
  String AcademyName;
  CourseDetail({this.AcademyName});

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List list = ['All'];
  String selected = "All";

  @override
  void initState() {
    super.initState();
    get();
  }

  void get() {
    Services.getClass(widget.AcademyName).then((classlist) {
      list = ['All'];
      for (int i = 0; i < classlist.length; i++) {
        list.add(classlist[i]);
        print(classlist[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topRight,
          width: 100,
          child: DropdownButton(
              hint: Text(
                selected,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              isExpanded: true,
              items: list.map((clas) {
                return DropdownMenuItem(
                  child: Text(
                    clas,
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  value: clas,
                );
              }).toList(),
              onChanged: (value) {
                get();
                selected = value;
                Services.getCourse(widget.AcademyName, selected);
              }),
        ),
        Expanded(
          child: Center(
            child: FutureBuilder<List>(
              future: Services.getCourse(widget.AcademyName, selected),
              builder: (ctx, ss) {
                if (ss.hasError) {
                  print("Error");
                }
                if (ss.hasData) {
                  return Itemss(list: ss.data);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Itemss extends StatelessWidget {
  List list;
  Itemss({this.list});

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
