import 'package:flutter/material.dart';
import 'package:mony_manager_new/locator.dart';
import 'package:mony_manager_new/ui/router.dart';
import 'package:mony_manager_new/ui/shared/app_colors.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: backgroundColor,
        accentColor: Colors.blue,
      ),
      initialRoute: '/',
      //onGenerateRoute: Router.generateRoute,
    );
  }
}
