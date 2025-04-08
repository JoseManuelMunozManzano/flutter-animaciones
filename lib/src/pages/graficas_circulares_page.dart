import 'package:flutter/material.dart';

import 'package:design_app/src/widgets/radial_progress.dart';

class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({super.key});

  @override
  State<GraficasCircularesPage> createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {

  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if (porcentaje > 100) {
              porcentaje = 0.0;
            }
          });
        }
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.blue),
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.red),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.pink),
              CustomRadialProgressGradient(porcentaje: porcentaje),
            ],
          )
        ],
      )
    );
  }
}

class CustomRadialProgress extends StatelessWidget {

  final Color color;

  const CustomRadialProgress({
    super.key,
    required this.porcentaje,
    required this.color,
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgress(
        porcentaje: porcentaje,
        colorPrimario: color,
        colorSecundario: Colors.grey,
        grosorPrimario: 10.0,
        grosorSecundario: 4.0,
      ),
      // child: Text('$porcentaje %', style: TextStyle(fontSize: 50.0))
    );
  }
}

class CustomRadialProgressGradient extends StatelessWidget {

  final Rect rect = Rect.fromCircle(
    center: Offset(0, 0),
    radius: 180,
  );

  final Gradient gradiente = LinearGradient(
    colors: [
      Color(0xffc012ff),
      Color(0xff6d05e8),
      Colors.red,
    ]
  );

  CustomRadialProgressGradient({
    super.key,
    required this.porcentaje,
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgress(
        porcentaje: porcentaje,
        colorSecundario: Colors.grey,
        grosorPrimario: 10.0,
        grosorSecundario: 4.0,
        gradiente: gradiente.createShader(rect),
      ),
      // child: Text('$porcentaje %', style: TextStyle(fontSize: 50.0))
    );
  }
}


