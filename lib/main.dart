import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';

import 'package:design_app/src/pages/launcher_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // Este número debe estar guardado en la preferencias de usuario.
      // Se manda al ThemeChanger y en base a el se escoge el tema.
      create: (_) => ThemeChanger(2),
      child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: LauncherPage()
    );
  }
}
