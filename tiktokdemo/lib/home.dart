import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokdemo/pages/addvideo.dart';
import 'package:tiktokdemo/pages/messages.dart';
import 'package:tiktokdemo/pages/profile.dart';
import 'package:tiktokdemo/pages/search.dart';
import 'package:tiktokdemo/pages/video.dart';
import 'package:tiktokdemo/variable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pageOptions = [Video(), Search(), AddVideoPage(), Messages(), Profile()];
  int page = 0;
  customeIcon() {
    return Container(
      width: 45,
      height: 17,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 100),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 211, 234),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.add,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageOptions[page],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          selectedItemColor: Colors.lightBlue,
          unselectedItemColor: Colors.black,
          currentIndex: page,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
                style: mystyle(12),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(
                "Search",
                style: mystyle(12),
              ),
            ),
            BottomNavigationBarItem(
              icon: customeIcon(),
              title: Text(
                "",
                style: mystyle(12),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text(
                "Messages",
                style: mystyle(12),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                "Profile",
                style: mystyle(12),
              ),
            ),
          ],
        ));
  }
}
