import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: 'TitilliumWeb',
  primarySwatch: Colors.yellow,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.DARK_BG_COLOR,
  primaryColor: AppColors.PRIMARY_COLOR,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white54),
    caption: TextStyle(color: Colors.white54),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.DARK_BG_COLOR,
  ),
);

final ThemeData lightTheme = ThemeData(
  fontFamily: 'TitilliumWeb',
  primarySwatch: Colors.yellow,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: AppColors.PRIMARY_COLOR,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    iconTheme: IconThemeData(color: AppColors.BAR_ITEM_COLOR),
    titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: AppColors.DARK_COLOR),
    bodyText1: TextStyle(color: AppColors.TEXT_COLOR),
    bodyText2: TextStyle(color: AppColors.TEXT_LIGHT_COLOR),
    caption: TextStyle(color: AppColors.TEXT_COLOR_THREE),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
);
