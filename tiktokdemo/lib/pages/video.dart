import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktokdemo/variable.dart';

class Video extends StatefulWidget {
  const Video({Key key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  buildProfile() {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: (62 / 2) - (50 / 2),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    height: 10,
                    width: 10,
                    image: NetworkImage(
                        'https://en.wikipedia.org/wiki/File:Blue_Unknot.png'),
                    //fit: BoxFit.cover,
                  ),
                  /// TODO this is the area where i found an error
                ),
              )),
        ],
      ),
    );
  }

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
                        //right section
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 150),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildProfile(),
                            ],
                          ),
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
