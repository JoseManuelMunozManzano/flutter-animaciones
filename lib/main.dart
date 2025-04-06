import 'package:flutter/material.dart';

// import 'package:design_app/src/pages/headers_page.dart';
// import 'package:design_app/src/pages/animaciones_page.dart';
import 'package:design_app/src/retos/cuadrado_animado_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      // home: HeadersPage()
      // home: AnimacionesPage()
      home: CuadradoAnimadoPage()
    );
  }
}
