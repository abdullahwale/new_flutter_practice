import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/retrieve.dart';
import 'package:intl/intl.dart';
import 'package:firebase_practice/save.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetData _getData = new GetData();
  //String data;
  TextEditingController nameTF = new TextEditingController();
  TextEditingController phoneTF = new TextEditingController();
  TextEditingController dobTF = new TextEditingController();
  final db = FirebaseFirestore.instance;
  final format = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: myTextField('Name', nameTF),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: DateTimeField(
                  format: format,
                  controller: dobTF,
                  decoration: InputDecoration(
                      labelText: 'Date of Birth', border: OutlineInputBorder()),
                  onShowPicker: (context, _dateTime) {
                    return showDatePicker(
                        context: context,
                        initialDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: myTextField('Phone No:', phoneTF),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RetrieveData()));
                      },
                      child: Text('Show Data',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      color: Colors.green),
                  SizedBox(width: 10),
                  FlatButton(
                      onPressed: () {
                        if (nameTF.text.isNotEmpty &&
                            dobTF.text.isNotEmpty &&
                            phoneTF.text.isNotEmpty) {
                          Map<String, dynamic> data = {
                            'Name': nameTF.text,
                            'DOB': dobTF.text,
                            'Phone': phoneTF.text,
                            'Entry': Timestamp.now()
                          };
                          _getData.saveData('task', data);
                          nameTF.clear();
                          phoneTF.clear();
                          dobTF.clear();
                        } else {
                          Alert(
                                  context: context,
                                  title: 'Please Fill all the Field',
                                  onWillPopActive: true)
                              .show();
                        }
                      },
                      child: Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      color: Colors.indigo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField myTextField(String hint, var control) {
    return TextField(
      controller: control,
      decoration:
          InputDecoration(labelText: hint, border: OutlineInputBorder()),
    );
  }
}
