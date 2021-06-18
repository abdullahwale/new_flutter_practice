import 'package:flutter_mysql/Management/ManagerManagement/AddManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/Owner/OwnerHome.dart';

class ManagerManagementHome extends StatefulWidget {
  String academyName;
  ManagerManagementHome({this.academyName});
  @override
  _ManagerManagementHomeState createState() => _ManagerManagementHomeState();
}

class _ManagerManagementHomeState extends State<ManagerManagementHome> {
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
          title: Text('Manager'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ManagerManagementHome(
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
                future: Services.getManager("manager", widget.academyName),
                builder: (ctx, ss) {
                  if (ss.hasError) {
                    print("Error");
                  }
                  if (ss.hasData) {
                    if (ss.data.length == 0) {
                      return NoData();
                    }
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
                    builder: (context) => AddManager(
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
              list[i]['email'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              list[i]['password'],
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

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "No Manager exist",
        style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
      ),
    );
  }
}
