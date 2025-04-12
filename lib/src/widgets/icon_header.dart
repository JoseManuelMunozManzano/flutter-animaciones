import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHeader extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;

  const IconHeader({
    super.key,
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    this.color1 = const Color(0xff526BF6),
    this.color2 = const Color(0xff67ACF2),
  });

  @override
  Widget build(BuildContext context) {

    final Color colorBanco = Colors.white.withValues(alpha: 0.7);

    return Stack(
      children: [
        _IconHeaderBackground(color1, color2),
        Positioned(
          top: -50,
          left: -70,
          child: FaIcon(icon, size: 250, color: Colors.white.withValues(alpha: 0.2))
        ),
        Column(
          children: [
            // Los widgets se centran en base al más largo. Por eso aquí indico que el ancho es infinito.
            // Ahora este widget es el que se expande y se usa como referencia para centrar los demás.
            SizedBox(height: 80, width: double.infinity,),
            Text(titulo, style: TextStyle(fontSize: 20, color: colorBanco)),
            SizedBox(height: 20),
            Text(subtitulo, style: TextStyle(fontSize: 25, color: colorBanco, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            FaIcon(icon, size: 80, color: Colors.white)
          ],
        )
      ]
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _IconHeaderBackground(
    this.color1,
    this.color2
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color1, color2]
        )
      ),
    );
  }
}
