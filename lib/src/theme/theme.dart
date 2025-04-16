import 'package:flutter/material.dart';

// Modelo responsable para todo lo que tenga que ver con el tema de la aplicación
class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;
  late ThemeData _currentTheme;

  bool get darkTheme => _darkTheme;
  bool get customTheme => _customTheme;
  ThemeData get currentTheme => _currentTheme;

  // Hacemos el contructor para recuperar el tema del usuario desde el principio.
  ThemeChanger(int theme) {
    switch (theme) {
      case 1: // light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
        break;
      case 2: // dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(primary: Colors.pink)
        );
        break;
      case 3: // dark
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = ThemeData.light();
        break;
      default:
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  set darkTheme(bool value) {
    _customTheme = false;
    _darkTheme = value;

    if (value) {
      _currentTheme = ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(primary: Colors.pink)
      );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

  set customTheme(bool value) {
    _customTheme = value;
    _darkTheme = false;

    if (value) {
      _currentTheme = ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Color(0xff48A0EB),
        ),
        scaffoldBackgroundColor: Color(0xff16202B),
        primaryColorLight: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white)
        )
      );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }
}
