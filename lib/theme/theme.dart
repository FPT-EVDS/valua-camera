import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const primaryColor = Color(0xFF1890FF);
  final BuildContext _context;

  AppThemes(this._context);

  ThemeData get defaultTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 18,
          color: Colors.black, //change your color here
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      primaryColor: primaryColor,
      primarySwatch: Colors.blue,
      fontFamily: 'Inter',
      textTheme: GoogleFonts.interTextTheme(Theme.of(_context).textTheme),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(fontSize: 18),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: primaryColor),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
    );
  }
}
