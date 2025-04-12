import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGordo extends StatelessWidget {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final VoidCallback onPress;

  const BotonGordo({
    super.key,
    this.icon = FontAwesomeIcons.circle,
    required this.texto,
    this.color1 = const Color(0xff6989F5),
    this.color2 = const Color(0xff906EF5),
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          _BotonGordoBackground(icon, color1, color2),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140, width: 40),
              FaIcon(icon, color: Colors.white, size: 40),
              SizedBox(width: 20),
              Expanded(child: Text(texto, style: TextStyle(color: Colors.white, fontSize: 18))),
              FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {

  final IconData icon;
  final Color color1;
  final Color color2;

  const _BotonGordoBackground(this.icon, this.color1, this.color2);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: Offset(4, 6),
            blurRadius: 10
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [color1, color2]
        )
      ),

      // Utilizo ClipRRect porque al hacer el Positioned el icono se sale un poquito
      // del container, ya que este tiene bordes redondeados.
      // ClipRRect nos permite cortar los bordes, en este caso corta el borderRadius indicado.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon(icon, size: 150, color: Colors.white.withValues(alpha: 0.2))
            )
          ],
        ),
      ),
    );
  }
}
