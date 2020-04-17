import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/configs/themes.dart';

class ThemeSwitcher extends ChangeNotifier {
  bool lightThemeBool = true;

  getTheme() => lightThemeBool ? lightTheme : darkTheme;

  isLightTheme() => lightThemeBool;

  changeTheme() async {
    lightThemeBool = !lightThemeBool;
    notifyListeners();
  }
}
