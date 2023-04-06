// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

enum AppTheme { dark, light }

String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'SF-Pro-Display',
    backgroundColor: Color(0xFF0F172A),
    scaffoldBackgroundColor: Color(0xFF0F172A),
    primaryColor: Color(0xFF0F172A),
    errorColor: Color(0xFFFF554A),
    buttonTheme: ButtonThemeData(disabledColor: Color(0xFFFFFFFF)),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF0F172A), shadowColor: Colors.transparent),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      focusColor: Color(0xFF60A5FA),
      hoverColor: Color(0xFFFFB524),
      fillColor: Color(0xFF0F172A),
      filled: true,
      errorMaxLines: 3,
      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xFF64748B)),
      errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Color(0xFFF42827)),
      contentPadding: EdgeInsets.fromLTRB(30, 20, 20, 20),
      isCollapsed: true,
      isDense: true,
      // iconColor: Color(0xFFAAAAA8),
      prefixIconColor: Color(0xFF64748B),
      suffixIconColor: Color(0xFF64748B),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF273757), width: 1)),
      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC4CFC9), width: 1)),
      border: OutlineInputBorder(borderSide: BorderSide(color: Color(0x33D0D0D0), width: 1)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF33635), width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF42827), width: 1)),
      labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF003C93)),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF6699FF),
        minimumSize: Size(100, 40),
        textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        padding: EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Color(0xFF6699FF),
        minimumSize: Size(100, 40),
        textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
        padding: EdgeInsets.symmetric(horizontal: 15),
        side: BorderSide(color: Color(0xFF6699FF)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Color(0xFF0F172A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      elevation: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFFFFFFFF),
      unselectedItemColor: Color(0xFFFCFCFC).withOpacity(0.24),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xFFF1F5F9)),
      bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFFF1F5F9)),
      bodyText2: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFFF1F5F9)),
      headline5: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFFF1F5F9)),
      subtitle1: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF64748C)),
    ),
  ),
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    fontFamily: 'SF-Pro-Display',
  )
};
