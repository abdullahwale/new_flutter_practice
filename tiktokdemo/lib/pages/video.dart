import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokdemo/variable.dart';

class Video extends StatefulWidget {
  const Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Column(
            //top Section
            children: [
              Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Following",
                      style: mystyle(17, Colors.white, FontWeight.bold),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "For You",
                      style: mystyle(17, Colors.white, FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //Middle Section
              Expanded(
                  child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Abdullah",
                            style: mystyle(15, Colors.white, FontWeight.bold)),
                        Text("Cool Video ",
                            style: mystyle(15, Colors.white, FontWeight.bold)),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 15,
                              color: Colors.white,
                            ),
                            Text("Simple-Song",
                                style:
                                    mystyle(15, Colors.white, FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
