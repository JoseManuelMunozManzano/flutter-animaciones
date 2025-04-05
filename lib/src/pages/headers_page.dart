import 'package:flutter/material.dart';

import 'package:design_app/src/widgets/headers.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: HeaderCuadrado(),
      // body: HeaderBordesRedondeados(),
      // body: HeaderDiagonal(),
      // body: HeaderTriangular(),
      // body: HeaderPico(),
      // body: HeaderCurvo(),
      // body: HeaderWave(),
      body: HeaderWaveGradient(),
    );
  }
}
