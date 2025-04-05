import 'package:flutter/material.dart';

// Mientras podamos hacer nuestros diseños con Container, así lo haremos.
// Esto es porque es mucho más fácil de usar que un Custom Painter.

class HeaderCuadrado extends StatelessWidget {
  const HeaderCuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Color(0xff615AAB),
    );
  }
}

class HeaderBordesRedondeados extends StatelessWidget {
  const HeaderBordesRedondeados({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
        ),
        color: Color(0xff615AAB),
      ),
    );
  }
}

// Es aquí donde ya empezamos a necesitar un Custom Painter.
class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderDiagonalPainter(),
      ),
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {

  // El size corresponde a lo indicado en height y width en su Container, en HeaderDiagonal.
  @override
  void paint(Canvas canvas, Size size) {
    // paint es el lápiz que vamos a usar para dibujar.
    final paint = Paint();

    // Propiedades
    paint.color = Color(0xff615AAB);
    // .stroke son los bordes y .fill es para rellenar.
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    // Como quiero mover mi paint. Por defecto path está en la posición (0, 0)
    final path = Path();

    // Dibujar con el path y paint
    // Con moveTo solo movemos el paint. Con lineTo dibujo.
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderTriangular extends StatelessWidget {
  const HeaderTriangular({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderTriangularPainter()),
    );
  }
}

class _HeaderTriangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    // Dibujar con el path y paint
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderPico extends StatelessWidget {
  const HeaderPico({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderPicoPainter()),
    );
  }
}

class _HeaderPicoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    // Dibujar con el path y paint
    path.lineTo(0, size.height * .25);
    path.lineTo(size.width * .5, size.height * .3);
    path.lineTo(size.width, size.height * .25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderCurvo extends StatelessWidget {
  const HeaderCurvo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderCurvoPainter()),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    // Dibujar con el path y paint
    path.lineTo(0, size.height * .20);
    // Las primeras dos coordenadas (x1, y1), es el eje de curvatura, es decir, en qué punto
    //   tiene que pasar la línea.
    // Las últimas dos coordenadas (x2, y2), apuntan al lugar final donde debe de llegar la línea.
    path.quadraticBezierTo(size.width * .5, size.height * .4, size.width, size.height * .20);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderWave extends StatelessWidget {
  const HeaderWave({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderWavePainter()),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Propiedades
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    // Dibujar con el path y paint
    // path.lineTo(0, size.height * .25);
    // path.quadraticBezierTo(size.width * .25, size.height * .3, size.width * .5, size.height * .25);
    // path.quadraticBezierTo(size.width * .75, size.height * .2, size.width, size.height * .25);
    // path.lineTo(size.width, 0);

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * .75);
    path.quadraticBezierTo(size.width * .25, size.height * .7, size.width * .5, size.height * .75);
    path.quadraticBezierTo(size.width * .75, size.height * .8, size.width, size.height * .75);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderWaveGradient extends StatelessWidget {
  const HeaderWaveGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(painter: _HeaderWaveGradientPainter()),
    );
  }
}

class _HeaderWaveGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final Rect rect = Rect.fromCircle(
      // Como es un gradiente horizontal, los cambios del offset en y no afectan. Lo dejo en 120.0
      center: Offset(155.0, 120.0),
      radius: 180,
    );

    final Gradient gradiente = LinearGradient(
      // Cambiando gradiente horizontal a vertical, donde el offset en y afecta y el x no.
      // begin: Alignment.topCenter,
      // end: Alignment.bottomCenter,
      colors: <Color>[
        Color(0xff6d05e8),
        Color(0xffc012ff),
        Color(0xff6d05fa),
      ],
      // Puntos porcentuales donde queremos que trabaje cada uno de los colores.
      // 0.0 es el inicio del gradiente y 1.0 es el final del gradiente.
      // Debe haber tantos stops como número de colores.
      stops: [
        0.3,
        0.6,
        1.0
      ],
    );

    // El shader viene como base de un gradiente.
    final paint = Paint()..shader = gradiente.createShader(rect);

    // Propiedades
    // El color se indica en el shader.
    // paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    // Dibujar con el path y paint
    path.lineTo(0, size.height * .25);
    path.quadraticBezierTo(size.width * .25, size.height * .3, size.width * .5, size.height * .25);
    path.quadraticBezierTo(size.width * .75, size.height * .2, size.width, size.height * .25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
