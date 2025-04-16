import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';

import 'package:design_app/src/widgets/headers.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({super.key});

  @override
  Widget build(BuildContext context) {

    final primaryColor = Provider.of<ThemeChanger>(context).currentTheme.colorScheme.primary;

    return Scaffold(
      // body: HeaderCuadrado(),
      // body: HeaderBordesRedondeados(),
      // body: HeaderDiagonal(),
      // body: HeaderTriangular(),
      // body: HeaderPico(),
      // body: HeaderCurvo(),
      body: HeaderWave(color: primaryColor),
      // body: HeaderWaveGradient(),
    );
  }
}
