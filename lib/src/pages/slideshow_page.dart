import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';

import 'package:design_app/src/widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Para controlar como se ven los slides en función del tamaño en pixeles del dispositivo.
    bool isLarge;
    if (MediaQuery.of(context).size.height > 500) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    final children = [
      Expanded(child: MiSlideshow()),
      Expanded(child: MiSlideshow()),
    ];

    return Scaffold(
      // backgroundColor: Colors.purple,
      // Si es suficientemente ancho (la altura) la muestro en columnas, sino en fila.
      body: isLarge 
        ? Column(children: children)
        : Row(children: children,)
    );
  }
}

class MiSlideshow extends StatelessWidget {
  const MiSlideshow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Slideshow(
      bulletPrimario: 20,
      bulletSecundario: 12,
      // puntosArriba: true,
      colorPrimario: (appTheme.darkTheme) ? appTheme.currentTheme.colorScheme.primary : Color(0xffFF5A7E),
      // colorSecundario: Colors.white,
      slides: [
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
        // Como slideshow.dart admite Widgets, esto también es correcto.
        // Text('Hola Mundo'),
        // Container(
        //   width: 200,
        //   height: 200,
        //   color: Colors.blue,
        // )
      ],
    );
  }
}
