import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_practice/update.dart';

class RetrieveData extends StatefulWidget {
  @override
  _RetrieveDataState createState() => _RetrieveDataState();
}

class _RetrieveDataState extends State<RetrieveData> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Record'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('task')
              .orderBy('Entry', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                        child: ListTile(
                      title: Text(ds["Name"]),
                      subtitle: Text('Date of Birth: ' +
                          ds["DOB"] +
                          '\nPhone: ' +
                          ds["Phone"]),
                      selectedTileColor: Colors.grey[700],
                      onLongPress: () {
                        db.collection('task').doc(ds.id).delete();
                      },
                      onTap: () {
                        UpdateData _updateData = new UpdateData();
                        _updateData.getData(
                            ds.id, ds["Name"], ds["DOB"], ds["Phone"]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateData()));
                      },
                    ));
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
