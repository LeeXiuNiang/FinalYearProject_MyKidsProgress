import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darktheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo[900],
        accentColor: Colors.redAccent,
        focusColor: Colors.redAccent,
        fontFamily: 'Georgia',
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.redAccent,
          cursorColor: Colors.redAccent,
          selectionColor: Colors.redAccent,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
              color: Colors.red[600]),
          headline2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.red[600]),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
              color: Colors.red[600]),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.redAccent,
        ));
  }

  static ThemeData get lighttheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo[900],
        accentColor: Colors.indigo,
        focusColor: Colors.redAccent,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.redAccent,
          cursorColor: Colors.redAccent,
          selectionColor: Colors.redAccent,
        ),
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
              color: Colors.indigo[900]),
          headline2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.indigo[900]),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
              color: Colors.indigo[900]),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo,
        ));
  }
}
