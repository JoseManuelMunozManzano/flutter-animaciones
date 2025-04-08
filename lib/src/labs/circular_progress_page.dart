import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({super.key});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    controller.addListener(() {
      // print('valor controller: ${controller.value}');

      // lerpDouble nos sirve para interpolar dos números.
      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value)!;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        onPressed: () {

          porcentaje = nuevoPorcentaje;
          nuevoPorcentaje += 10;
          if (nuevoPorcentaje > 100) {
            nuevoPorcentaje = 0;
          }

          // Especificamos valor entre 0.0 y 1.0, para indicar donde empezamos.
          // Cada vez que toquemos el botón se realiza la animación.
          // Sin el from, solo se realiza la primera vez.
          controller.forward(from: 0.0);

          setState(() {});
        },
        child: Icon(Icons.refresh_outlined),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 300,
          height: 300,
          // color: Colors.red,
          child: CustomPaint(
            painter: _MiRadialProgress(porcentaje),
          ),
        ),
      ),
    );
  }
}

class _MiRadialProgress extends CustomPainter {

  final double porcentaje;

  _MiRadialProgress(this.porcentaje);

  @override
  void paint(Canvas canvas, Size size) {

    //? Círculo completado
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    // Hay que indicar la posición, el radio y el lápiz con el que queremos que se dibuje.
    // El radio va desde el punto central hasta el borde.
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    //? Arco
    final paintArco = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;
    
    // Parte que se deberå ir llenando.
    // 2 * PI es un círculo completo y lo multiplico por el % que va llenándose.
    double arcAngle = 2 * pi * (porcentaje / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radio),
      -pi / 2,
      arcAngle,
      false,
      paintArco
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
