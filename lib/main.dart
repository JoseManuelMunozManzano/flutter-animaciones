import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';
import 'package:design_app/src/models/layout_model.dart';

import 'package:design_app/src/pages/launcher_page.dart';
import 'package:design_app/src/pages/launcher_tablet_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      // Este número debe estar guardado en la preferencias de usuario.
      // Se manda al ThemeChanger y en base a el se escoge el tema.
        ChangeNotifierProvider<ThemeChanger>(create: (_) => ThemeChanger(2)),
        ChangeNotifierProvider<LayoutModel>(create: (_) => LayoutModel()),
      ],
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
      // orientation me sirve para saber algún cambio de orientación en el dispositivo.
      home: OrientationBuilder(
        builder: (context, orientation) {
          // print('Orientation $orientation');

          // Pero lo importante es el tamaño del dispositivo.
          final screenSize = MediaQuery.of(context).size;

          // Tamaño de tableta.
          if (screenSize.width > 500) {
            return LauncherTabletPage();
          } else {
            return LauncherPage();
          }

        },
      )
    );
  }
}
