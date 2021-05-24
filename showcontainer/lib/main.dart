import 'package:flutter/material.dart';

void main() {
  runApp(TestScreen());
}

/*
These are the sample list for demo
 */
List<ItemVO> mainList = List();
List<ItemVO> sampleMenList = [
  ItemVO("1", "Mens 1"),
  ItemVO("2", "Mens 2"),
  ItemVO("3", "Mens 3")
];
List<ItemVO> sampleWomenList = [
  ItemVO("1", "Women 1"),
  ItemVO("2", "Women 2"),
  ItemVO("3", "Women 3")
];
List<ItemVO> sampleKidsList = [
  ItemVO("1", "kids 1"),
  ItemVO("2", "kids 2"),
  ItemVO("3", "kids 3")
];

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestScreen();
  }
}

class _TestScreen extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
    mainList.addAll(sampleMenList);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (BuildContext context, index) {
              return getCard(index);
            },
            itemCount: mainList.length,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleMenList);
                    });
                  },
                  heroTag: "btn1",
                  child: Text("Mens"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleWomenList);
                    });
                  },
                  heroTag: "btn2",
                  child: Text("Women"),
                ),
                FloatingActionButton(
                  onPressed: () {
                    mainList.clear();
                    setState(() {
                      mainList.addAll(sampleKidsList);
                    });
                  },
                  heroTag: "btn3",
                  child: Text("Kids"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
    Get the card item for a list
   */
  getCard(int position) {
    ItemVO model = mainList[position];
    return Card(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ID:: " + model._id,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Padding(padding: EdgeInsets.only(left: 5, right: 5)),
            Text(
              "Name:: " + model._name,
              style: TextStyle(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
      margin: EdgeInsets.all(10),
    );
  }
}

class ItemVO {
  String _id, _name;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  ItemVO(this._id, this._name);
}
/*
Custom model
i.e. for itemList
 */

//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("Show Hide View on Button Click"),
//           ),
//           body: SafeArea(
//               child: Center(
//             child: ViewWidget(),
//           ))),
//     );
//   }
// }
//
// class ViewWidget extends StatefulWidget {
//   @override
//   ViewWidgetState createState() => ViewWidgetState();
// }
//
// class ViewWidgetState extends State {
//   bool viewVisible = true;
//
//   void showWidget() {
//     setState(() {
//       viewVisible = true;
//     });
//   }
//
//   void hideWidget() {
//     setState(() {
//       viewVisible = false;
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Visibility(
//             maintainSize: true,
//             maintainAnimation: true,
//             maintainState: true,
//             visible: viewVisible,
//             child: Container(
//                 height: 100,
//                 width: 100,
//                 color: Colors.green,
//                 margin: EdgeInsets.only(top: 50, bottom: 30),
//                 child: Center(
//                     child: Text('Its a Simple Container',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white, fontSize: 23))))),
//         RaisedButton(
//           child: Text('Hide Conatiner on Button Click'),
//           onPressed: hideWidget,
//           color: Colors.pink,
//           textColor: Colors.white,
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//         ),
//         RaisedButton(
//           child: Text('Show Conatiner on Button Click'),
//           onPressed: showWidget,
//           color: Colors.pink,
//           textColor: Colors.white,
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//         ),
//       ],
//     );
//   }
// }
