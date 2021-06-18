import 'package:flutter_mysql/Services/Academy.dart';
import 'package:flutter_mysql/SuperAdmin/ModifyAcademy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/SuperAdmin/AddAcademy.dart';
import 'package:flutter_mysql/Shared/Background.dart';

class SuperHome extends StatefulWidget {
  @override
  _SuperHomeState createState() => _SuperHomeState();
}

class _SuperHomeState extends State<SuperHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SuperHome()));
              },
            ),
          ],
          title: Text('Super Admin'),
          backgroundColor: Colors.orange,
        ),
        body: Stack(
          children: <Widget>[
            Background(),
            SafeArea(
              child: Container(
                child: Center(
                  child: FutureBuilder<List>(
                    future: Services.getdata(),
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AddAcademy()));
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
            title: Text(list[i]['academy_name']),
            subtitle: Text(list[i]['academy_address']),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModifyAcademy(
                            academyList: list,
                            index: i,
                          )));
            },
          );
        });
  }
}
