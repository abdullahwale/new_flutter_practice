import 'package:cloud_firestore/cloud_firestore.dart';

class GetData {
  final db = FirebaseFirestore.instance;
  void saveData(String col, Map<String, dynamic> getData) {
    db.collection(col).add(getData);
    //  db.collection(col).add(getData);
  }

  void updateData(String col, String id, Map<String, dynamic> getData) {
    db.collection(col).doc(id).update(getData);
    //  db.collection(col).add(getData);
  }
}
