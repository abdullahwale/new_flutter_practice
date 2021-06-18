import 'package:flutter/material.dart';
import 'package:flutter_mysql/Shared/Home.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  String result = '';
  var Colorsval = Colors.white;

  @override
  void initState() {
    CheckStatus();
    super.initState();
  }

  void CheckStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        ChangeValues("Connected", Colors.green[900]);
        loadData();
      } else {
        ChangeValues("No Internet", Colors.red[900]);
        loadData();
        screen();
      }
    });
  }

  void ChangeValues(String resultval, Color colorval) {
    setState(() {
      result = resultval;
      Colorsval = colorval;
    });
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    /*var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      screen();
      // Mobile is not Connected to Internet
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
    else if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }

    else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }*/
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('Assets/bg_images/splash.jpg'), fit: BoxFit.fill),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }
}

Widget screen() {
  return Scaffold(
    body: Center(
      child: Text(
        'No Internet',
        style: TextStyle(fontSize: 24.0),
      ),
    ),
  );
}
