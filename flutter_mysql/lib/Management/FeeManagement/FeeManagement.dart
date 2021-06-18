import 'package:flutter/material.dart';
import 'package:flutter_mysql/Services/Services.dart';
import 'package:flutter_mysql/Owner/OwnerHome.dart';
import 'package:flutter_mysql/Management/FeeManagement/AddFee.dart';

class FeeManagementHome extends StatefulWidget {
  String academyName;
  FeeManagementHome({this.academyName});
  @override
  _FeeManagementHomeState createState() => _FeeManagementHomeState();
}

class _FeeManagementHomeState extends State<FeeManagementHome> {
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
          title: Text('Fee'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeeManagementHome(
                              academyName: widget.academyName,
                            )));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                DefaultTabController(
                    length: 2, // length of tabs
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
                                  text: 'Paid',
                                ),
                                Tab(text: 'Unpaid'),
                              ],
                            ),
                          ),
                          Container(
                              height: 400, //height of TabBarView
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(children: <Widget>[
                                Container(
                                  child: Center(
                                    child: FutureBuilder<List>(
                                      future:
                                          Services.getPaid(widget.academyName),
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
                                Container(
                                  child: Center(
                                    child: FutureBuilder<List>(
                                      future: Services.getUnpaid(
                                          widget.academyName),
                                      builder: (ctx, ss) {
                                        if (ss.hasError) {
                                          print("Error");
                                        }
                                        if (ss.hasData) {
                                          return Items1(list: ss.data);
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ]))
                        ])),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddFee(
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
              list[i]['roll_no'] +
                  ":" +
                  list[i]['student_name'] +
                  "  " +
                  list[i]['class'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              "0",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            ),
          );
        });
  }
}

class Items1 extends StatelessWidget {
  List list;
  Items1({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(
              list[i]['roll_no'] +
                  ":" +
                  list[i]['student_name'] +
                  "  " +
                  list[i]['class'],
              style: TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              list[i]['fee'],
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            ),
          );
        });
  }
}
