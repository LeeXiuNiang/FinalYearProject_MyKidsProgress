import 'package:flutter/material.dart';
import 'package:mykidsprogress/splashscreen.dart';

import 'loginscreen.dart';
// import 'mainscreen.dart';
// import 'registrationscreen.dart';
// import 'splashscreen.dart';
import 'themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.lighttheme,
        routes: <String, WidgetBuilder>{
          '/loginscreen': (BuildContext context) => new LoginScreen(),
          //'/registerscreen': (BuildContext context) => new RegistrationScreen(),
          //'/mainscreen': (BuildContext context) => new MainScreen(),
        },
        title: 'MyKidsProgress',
        home: SplashScreen());
        // home: LoginScreen());
  }
}
