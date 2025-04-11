import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_app/src/models/slider_model.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Inicialización.
      // Obtenemos una instancia única a partir de este punto hacia abajo.
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Utilizamos todo el espacio posible para la imagen.
              Expanded(
                child: _Slides()
              ),
              _Dots(),
            ],
          )
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;
  
  const _Dot(this.index);

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
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5) 
            ? Colors.blue: Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {

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
      // print('Página actual: ${pageViewController.page}');

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
        children: [
          _Slide('assets/svgs/slide-1.svg'),
          _Slide('assets/svgs/slide-2.svg'),
          _Slide('assets/svgs/slide-3.svg'),
        ],
      )
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;

  const _Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}
