import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

const darkblue = Color.fromARGB(255, 4, 50, 88);
const lightblue = Color.fromRGBO(66, 163, 181, 1);
const yellow = Color.fromRGBO(246, 176, 66, 1.0);
const putih = Colors.white;
const hitam = Colors.black;
const artinya = Color.fromARGB(255, 81, 80, 80);
const lightgreen = Color.fromARGB(255, 122, 232, 185);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: darkblue,
    scaffoldBackgroundColor: putih,
    tabBarTheme: TabBarTheme(
        unselectedLabelColor: lightblue,
        labelColor: darkblue,
        indicatorColor: darkblue),
    appBarTheme: AppBarTheme(
      backgroundColor: putih,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
  );

ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: lightblue,
    scaffoldBackgroundColor: darkblue,
    dialogBackgroundColor: darkblue,
    tabBarTheme: TabBarTheme(
        unselectedLabelColor: putih,
        dividerColor: putih,
        labelColor: lightblue,
        indicatorColor: lightblue),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: darkblue,
    ),
);
