import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_practice/save.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String id;
TextEditingController nameTF = new TextEditingController();
TextEditingController dobTF = new TextEditingController();
TextEditingController phoneTF = new TextEditingController();

class UpdateData extends StatefulWidget {
  void getData(String getId, String name, String dob, String phone) {
    id = getId;
    nameTF.text = name;
    dobTF.text = dob;
    phoneTF.text = phone;
    print(dobTF.text);
  }

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  GetData _getData = new GetData();
  final format = DateFormat('dd-MM-yyyy');
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Record'),
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
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder()),
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
                        _getData.updateData('task', id, data);
                        nameTF.clear();
                        phoneTF.clear();
                        dobTF.clear();
                      } else {
                        Alert(
                                context: context,
                                title: 'Data updated Successfully',
                                onWillPopActive: true)
                            .show();
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    color: Colors.indigo),
              ],
            ),
          ),
        ));
  }

  TextField myTextField(String hint, var control) {
    return TextField(
      controller: control,
      decoration:
          InputDecoration(labelText: hint, border: OutlineInputBorder()),
    );
  }
}
