import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:design_app/src/widgets/icon_header.dart';
import 'package:design_app/src/widgets/boton_gordo.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2);
}

class EmergencyPage extends StatelessWidget {

  const EmergencyPage({super.key});

   @override
    Widget build(BuildContext context) {

      // Para controlar como se ve en función del tamaño en pixeles del dispositivo.
      // Si es mayor de 500px puedo mostrar el encabezado.
      // print('H: ${MediaQuery.of(context).size.height}');
      bool isLarge;
      if (MediaQuery.of(context).size.height > 500) {
        isLarge = true;
      } else {
        isLarge = false;
      }

      final items = <ItemBoton>[
        ItemBoton( FontAwesomeIcons.carBurst, 'Motor Accident', Color(0xff6989F5), Color(0xff906EF5) ),
        ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2), Color(0xff536CF6) ),
        ItemBoton( FontAwesomeIcons.masksTheater, 'Theft / Harrasement', Color(0xffF2D572), Color(0xffE06AA3) ),
        ItemBoton( FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183), Color(0xff46997D) ),
        ItemBoton( FontAwesomeIcons.carBurst, 'Motor Accident', Color(0xff6989F5), Color(0xff906EF5) ),
        ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2), Color(0xff536CF6) ),
        ItemBoton( FontAwesomeIcons.masksTheater, 'Theft / Harrasement', Color(0xffF2D572), Color(0xffE06AA3) ),
        ItemBoton( FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183), Color(0xff46997D) ),
        ItemBoton( FontAwesomeIcons.carBurst, 'Motor Accident', Color(0xff6989F5), Color(0xff906EF5) ),
        ItemBoton( FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2), Color(0xff536CF6) ),
        ItemBoton( FontAwesomeIcons.masksTheater, 'Theft / Harrasement', Color(0xffF2D572), Color(0xffE06AA3) ),
        ItemBoton( FontAwesomeIcons.personBiking, 'Awards', Color(0xff317183), Color(0xff46997D) ),
      ];

      List<Widget> itemMap = items.map(
        (item) => FadeInLeft(
          duration: Duration(milliseconds: 250),
          child: BotonGordo(
            icon: item.icon,
            texto: item.texto,
            color1: item.color1,
            color2: item.color2,
            onPress: () {print('Click ${item.texto}');}
          ),
        )
      ).toList();

      return Scaffold(
        // Añadido para saber cuando los iconos se salen de los límites establecidos por el container.
        // backgroundColor: Colors.red,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: isLarge ? 220 : 10),
              child: SafeArea(
                child: ListView(
                  // Para que al llegar al final de la lista, el comportamiento sea como el de Ios,
                  // es decir, que haga un rebote.
                  // En Android queda más feo y por eso lo corregimos.
                  physics: BouncingScrollPhysics(),
                  children: [
                    if (isLarge)
                      SizedBox(height: 80),
                    ...itemMap,
                  ]
                ),
              ),
            ),

            if (isLarge)
              _Encabezado()
          ],
        )
      );
    }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconHeader(
          icon: FontAwesomeIcons.plus,
          titulo: 'Asistencia Médica',
          subtitulo: 'Has solicitado',
          color1: Color(0xff536CF6),
          color2: Color(0xff66A9F2),
        ),

        Positioned(
          right: 0,
          top: 45,
          child: RawMaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            child: FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.white)
          )
        ),
      ],
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: FontAwesomeIcons.plus,
      titulo: 'Has solicitado',
      subtitulo: 'Asistencia Médica',
    );
  }
}

