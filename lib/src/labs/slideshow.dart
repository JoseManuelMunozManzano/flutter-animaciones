import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/models/slider_model.dart';

class Slideshow extends StatelessWidget {

  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;

  const Slideshow({
    super.key,
    required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (puntosArriba)
                _Dots(slides.length, colorPrimario, colorSecundario),
              // Utilizamos todo el espacio posible para la imagen.
              Expanded(
                child: _Slides(slides)
              ),
              if (!puntosArriba)
                _Dots(slides.length, colorPrimario, colorSecundario),
            ],
          )
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {

  final int totalSlides;
  final Color colorPrimario;
  final Color colorSecundario;

  const _Dots(
    this.totalSlides,
    this.colorPrimario,
    this.colorSecundario
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(i, colorPrimario, colorSecundario)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  final Color colorPrimario;
  final Color colorSecundario;  

  const _Dot(
    this.index,
    this.colorPrimario,
    this.colorSecundario
  );

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        // No podemos ser muy estrictos con pageViewIndex == index porque en el momento
        // en que empieza a moverse el slide ya no es exactamente el index.
        // color: (pageViewIndex == index) ? Colors.blue: Colors.grey,
        color:
            (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
                ? colorPrimario
                : colorSecundario,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {

  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    // En este listener estaremos escuchando el cambio de la página.
    // La primera página es la cero.
    pageViewController.addListener(() {
      // Actualizar el provider, sliderModel.
      // Regresa la instancia de la clase.
      Provider.of<SliderModel>(context, listen: false).currentPage = pageViewController.page!;
    });
  }

  @override
  void dispose() {
    // Cuando tenemos un controlador siempre es bueno hacer el dispose para
    // prevenir fugas de memoria.
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      child: PageView(
        // Asignamos nuestro controller al PageView
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}
