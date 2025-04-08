import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {

  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  final Shader? gradiente;

  const RadialProgress({
    super.key,
    required this.porcentaje,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.grosorPrimario = 10,
    this.grosorSecundario = 4,
    this.gradiente,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    super.initState();
    // La primera vez el porcentaje anterior es el porcentaje actual.
    porcentajeAnterior = widget.porcentaje;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Cada vez que se redibuja el widget la animación empieza de nuevo.
    controller.forward(from: 0.0);
    // Tenemos que saber la diferencia que tenemos que animar, que es el valor actual menos el anterior.
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    // Volvemos a establecer el porcentaje anterior.
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            // Recordar que controller.value va de 0.0 a 1.0
            painter: _MiRadialProgress(
              (widget.porcentaje - diferenciaAnimar) + (diferenciaAnimar * controller.value),
              widget.colorPrimario,
              widget.colorSecundario,
              widget.grosorPrimario,
              widget.grosorSecundario,
              widget.gradiente,
            )
          )
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {

  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;
  final Shader? gradiente;

  _MiRadialProgress(
    this.porcentaje,
    this.colorPrimario,
    this.colorSecundario,
    this.grosorPrimario,
    this.grosorSecundario,
    this.gradiente,
  );

  @override
  void paint(Canvas canvas, Size size) {

    //? Círculo completado
    final paint = Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;

    // Hay que indicar la posición, el radio y el lápiz con el que queremos que se dibuje.
    // El radio va desde el punto central hasta el borde.
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    //? Arco
    final paintArco = Paint()
      ..strokeWidth = grosorPrimario
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (gradiente == null) {
      paintArco.color = colorPrimario;
    } else {
      paintArco.shader = gradiente!;
    }
    
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
