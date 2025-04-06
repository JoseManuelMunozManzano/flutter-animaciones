import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimacionesPage extends StatelessWidget {
  const AnimacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

// Las animaciones necesitan estado.
class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    super.key,
  });

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> agrandar;

  // El initState() solo se ejecuta una vez.
  // Aunque hagamos un hotReload, el initState() no se vuelve a ejecutar.
  // Un hotRestart si vuelve a ejecutar el initState().
  // Aquí es donde se añaden los listeners.
  @override
  void initState() {
    super.initState();
    // Definimos el controlador 
    // vsync es para que cada cuadro esté cuadrado con la resolución de la pantalla, para que corra
    //     a los fps que tenga que correr.
    //     Añadimos a la clase el mixin (with SingleTickerProviderStateMixin) para que funciona vsync: this.
    //     Si necesitará más de un controller utilizaría TickerProviderStateMixin
    // durations es el tiempo que queremos que se reproduzca la ejecución, lo que va a durar la animación.
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 4000));

    // Definimos que tipo de animación quiero.
    // Usamos Tween, que espera dos argumentos.
    //   begin es cualquier número. Indico 0.0 grados
    //   end es el punto donde queremos que pare la rotación. En este caso indicamos que pare cuando de dos vueltas,
    //      ya que PI son 180 grados.
    // Indicamos quien controla la animación.
    //
    // rotacion = Tween(begin: 0.0, end: 2 * math.pi).animate(controller);
    //
    // Para añadir curves, mandamos un CurvedAnimation donde indicamos el controller y el tipo de curve que queremos.
    rotacion = Tween(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    // Definimos la opacidad.
    // Siempre va de 0.0 (totalmente invisible) a 1.0 (totalmente visible).
    // Aplico un curves y como tipo de curve un Interval para hacer que la animación de la opacidad dure 1sg.
    // Interval necesita un begin y un end, e iran de 0.0 a 1.0, siendo 0.0 el punto inicial en el que comienza
    // la animación y 1.0 el 100% de la animación (base en porcentajes)
    // El tercer argumento de Interval es de nuevo un curve, opcional.
    // Uso el mismo controller, es decir, el efecto de la opacidad va a durar 4sg, aunque se pueden
    //   definir intervalos de tiempo en un controller.
    opacidad = Tween(begin: 0.1, end: 1.0).animate(

      // Queremos que la opacidad empiece a aplicarse al inicio y que dure 1sg. Entonces como begin indicamos 0.0
      // que es cuando inicia la animación, y como end indicamos 0.25 que es cuando lleva 1sg (el 25% de los 4sg)
      CurvedAnimation(parent: controller, curve: Interval(0.0, 0.25, curve: Curves.easeOut))

      // Otro ejempo de Interval.
      // Queremos que la opacidad empiece a aplicarse al final y que dure 1sg. Entonces como begin indicamos 0.75
      // que es cuando la rotación lleva 3sg de los 4sg posibles, y como end indicamos 1.0, que es que acaba
      // cuando llega al final de la animación, que son los 4sg.
      // CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0, curve: Curves.easeOut))
    );

    // Podría empezar en 1.0 y acabar en 0.0, pero lo hacemos al revés porque en el Widget Opacity
    // vamos a restar opacidad.value y opacidadOut.value, para acabar obteniendo los valores que queremos.
    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(.75, 1.0, curve: Curves.easeOut))
    );

    // begin va a ser la posición donde me encuentro y end será la posición donde quiero que llegue, 200.0px.
    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    // begin va a ser el tamaño inicial. 0.0 es casi inexistente, y se va a ir agrandando hasta el doble
    // de su tamaño original.
    agrandar = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    // Los listener siempre se añaden en el initState.
    // Durante toda la reproducción de la animación vamos a estar disparando el listener.
    // Esto significa que podemos controlar todas las etapas de la animación.
    //a (comentada y sustituida por un reseteo).
    controller.addListener(() {
      // print('Status: ${controller.status}');

      // Comentar si se indica en el build repeat() en vez de forward().
      if (controller.status == AnimationStatus.completed) {
        // controller.reverse();

        // También puede estar aquí el repeat() en vez de en el buid().
        // controller.repeat();

        // Cuando termina la animación la resetea.
        // Con esto, con un hotReload se vuelve a lanzar la animación, ya que el state con el valor final
        // se ha reseteado.
        // Al añadir la opacidad, cuando termina la animación deja la opacidad con su valor inicial, 0.1
        // Al añadir el movimiento, cuando termina la animación deja el cuadrado donde estaba inicialmente.
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Play / Reproducción
    // Pasa del valor inicial al valor final.
    // Si ya está en el valor final no hace nada.
    // Con cada hot reload, si la animación se encuentra en el punto inicial, se ejecutará.
    // Si no queremos este comportamiento, nos podemos llevar esta sentencia al método initState().
    //
    controller.forward();
    //
    // Sustituyo forward() por repeat() si lo que queremos es que no pare nunca
    // controller.repeat();

    return AnimatedBuilder(
      animation: controller,
      // child es opcional. Si se informa es lo que vamos a recibir en el builder.
      // Es una facilidad donde podemos indicar el Widget, que no va a cambiar.
      // Es opcional porque se puede indicar directamente en el return del builder.
      // Lo bueno que tiene es que de esta forma SOLO SE CONTRUYE UNA VEZ Y SE PASA POR REFERENCIA.
      child: _Rectangulo(),
      builder: (BuildContext context, Widget? childRectangulo) {

        // No olvidar no dejar nunca un print en producción.
        // print('Opacidad: ${opacidad.status}');
        // print('Rotacion: ${rotacion.status}');

        // Aquí es donde estamos diciendo a Flutter que empiece a mover el Widget.
        return Transform.translate(
          // En este Offset, (0, 0) es la posición en la que me encuentro.
          // Para movernos a la derecha hay que incrementar la x, por ejemplo (3, 0)
          offset: Offset(moverDerecha.value, 0),
          // Aquí es donde estamos diciendo a Flutter que empiece a girar el Widget.
          child: Transform.rotate(
            angle: rotacion.value,
            child: Opacity(
              // opacidad acabará valiendo 1. Llegado el momento empieza la animación opacidadOut
              // y acabará valiendo 1. 1 - 1 = 0 -> el objeto desaparece.
              opacity: opacidad.value - opacidadOut.value,
              // Aquí es donde estamos diciendo a Flutter que empiece a agrandar el Widget.
              child: Transform.scale(
                scale: agrandar.value,
                // Si comentamos arriba del builder el child, aquí indicamos _Rectangulo()
                // Pero se construye cada vez y si es muy pesado, se puede notar.
                child: childRectangulo
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue
      ),
    );
  }
}
