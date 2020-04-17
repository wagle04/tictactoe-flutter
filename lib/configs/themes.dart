import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle lightText = GoogleFonts.firaSans(color: Colors.black87, fontSize: 20);

TextStyle darkText = GoogleFonts.firaSans(color: Colors.white, fontSize: 20);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.grey[200],
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  textTheme: TextTheme(
    title: lightText.copyWith(fontWeight: FontWeight.bold),
    body1: lightText,
    button: lightText,
  ),
  iconTheme: IconThemeData(color: Colors.black87),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1f1f1f),
  scaffoldBackgroundColor: Color(0xFF1f1f1f),
  backgroundColor: Colors.black,
  textTheme: TextTheme(
    title: darkText.copyWith(fontWeight: FontWeight.bold),
    body1: darkText,
    button: darkText,
  ),
  iconTheme: IconThemeData(color: Colors.white70),
);
