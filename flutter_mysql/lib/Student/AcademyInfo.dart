import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';

class AcademyInfo extends StatefulWidget {
  String AcademyName;
  AcademyInfo({this.AcademyName});

  @override
  _AcademyInfoState createState() => _AcademyInfoState();
}

class _AcademyInfoState extends State<AcademyInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      alignment: Alignment.centerLeft,
      child: Center(
        child: FutureBuilder<List>(
          future: Services.getdetail(widget.AcademyName),
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
              "Name:" + "\n" + list[i]['academy_name'] + "\n",
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              "Address:" +
                  "\n" +
                  list[i]['academy_address'] +
                  "\n" +
                  "\n" +
                  "City:" +
                  list[i]['city'],
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
