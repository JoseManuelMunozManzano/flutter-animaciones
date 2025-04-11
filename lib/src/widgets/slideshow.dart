import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {

  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow({
    super.key,
    required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.bulletPrimario = 12.0,
    this.bulletSecundario = 12.0,
  });

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
        // Asignamos los valores de colorPrimario y colorSecundario a nuestro provider.
        // Tenemos que asignar este valor dentro del ámbito de existencia de nuestro provider,
        // y una vez que se haya creado la instancia del provider.
        // El Builder construye primero el widget y luego trabaja en base al contexto.
          child: Builder(
            builder: (context) {
              Provider.of<_SlideshowModel>(context).colorPrimario = colorPrimario;
              Provider.of<_SlideshowModel>(context).colorSecundario = colorSecundario;

              Provider.of<_SlideshowModel>(context).bulletPrimario = bulletPrimario;
              Provider.of<_SlideshowModel>(context).bulletSecundario = bulletSecundario;

              return _CrearEstructuraSlideshow(puntosArriba: puntosArriba, slides: slides);
            }
          )
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    required this.puntosArriba,
    required this.slides,
  });

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (puntosArriba)
          _Dots(slides.length),
        // Utilizamos todo el espacio posible para la imagen.
        Expanded(
          child: _Slides(slides)
        ),
        if (!puntosArriba)
          _Dots(slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {

  final int totalSlides;

  const _Dots(
    this.totalSlides,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(i)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    double tamano;
    Color color;

    // No podemos ser muy estrictos con pageViewIndex == index porque en el momento
    // en que empieza a moverse el slide ya no es exactamente el index.
    // color: (pageViewIndex == index) ? Colors.blue: Colors.grey,
    if (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) {
      tamano = ssModel.bulletPrimario;
      color = ssModel.colorPrimario;
    } else {
      tamano = ssModel.bulletSecundario;
      color = ssModel.colorSecundario;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      // El bullet activo tiene un tamaño primario y los no activos secundario
      width: tamano,
      height: tamano,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
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
      // Actualizar el provider, _SlideshowModel.
      // Regresa la instancia de la clase.
      Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageViewController.page!;
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


// Si quiero llevarme este widget a otro proyecto, no quiero llevarme el modelo.
// Por eso he copiado el código de slider_model.dart aquí.
class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;
  double _bulletPrimario = 12.0;
  double _bulletSecundario = 12.0;

  double get currentPage => _currentPage;

  set currentPage(double pagina) {
    _currentPage = pagina;
    notifyListeners();
  }

  Color get colorPrimario => _colorPrimario;

  set colorPrimario(Color color) {
    _colorPrimario = color;
  }

  Color get colorSecundario => _colorSecundario;

  set colorSecundario(Color color) {
    _colorSecundario = color;
  }

  double get bulletPrimario => _bulletPrimario;

  set bulletPrimario(double tamano) {
    _bulletPrimario = tamano;
  }

  double get bulletSecundario => _bulletSecundario;

  set bulletSecundario(double tamano) {
    _bulletSecundario = tamano;
  }
}
