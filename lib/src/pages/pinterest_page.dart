import 'package:design_app/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:design_app/src/widgets/pinterest_menu.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({super.key});

   @override
    Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        // A partir de aquí es donde quiero empezar a usar mi Provider.
        create: (_) => _MenuModel(),
        child: Scaffold(
          // body: PinterestGrid(),
          // body: PinterestMenu(),
          body: Stack(
            children: [
              PinterestGrid(),
              // Positioned nos permite ubicar un widget dentro de un Stack.
              _PinterestMenuLocation(),
            ],
          )
        ),
      );
    }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    // Para centrar el menú.
    // Resto 300 px porque es lo que ocupa el menú de la izquierda en tabletas.
    print(MediaQuery.of(context).size.width);
    if (widthPantalla > 500) {
      widthPantalla = widthPantalla - 300;
    }

    return Positioned(
      bottom: 30,
      child: SizedBox(
        width: widthPantalla,
        child: Row(
          children: [
            Spacer(),
            PinterestMenu(
              mostrar: mostrar,
              backgroundColor: appTheme.scaffoldBackgroundColor,
              activeColor: appTheme.colorScheme.primary,
              // inactiveColor: Colors.red,
              items: [
                  PinterestButton(onPressed: (){print('Icon pie_chart');}, icon: Icons.pie_chart),
                  PinterestButton(onPressed: (){print('Icon search');}, icon: Icons.search),
                  PinterestButton(onPressed: (){print('Icon notifications');}, icon: Icons.notifications),
                  PinterestButton(onPressed: (){print('Icon supervised_user_circle');}, icon: Icons.supervised_user_circle),
                ],
            ),
            Spacer(),
          ],
        )
      )
    );
  }
}

class PinterestGrid extends StatefulWidget {

  const PinterestGrid({super.key});

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);

  // Para saber si hacemos scroll arriba o abajo.
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      // print('ScrollListener ${controller.offset}');
      // Esta parte controller.offset > 150 se pone para que al subir arriba del todo,
      // al hacer el rebote, no aparezca y desaparezca el menú.
      if (controller.offset > scrollAnterior && controller.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
        // print('Ocultar menú');
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
        // print('Mostrar menú');
      }
      scrollAnterior = controller.offset;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Indicar si son distintos dispositivos, se puede hacer un switch teniendo
    // en cuento distintos pixeles para mostrar más o menos columnas.
    int count;
    if (MediaQuery.of(context).size.width > 500) {
      count = 3;  // 3 columnas
    } else {
      count = 2; // 2 columnas
    }

    return StaggeredGridView.countBuilder(
      // Indicamos el ScrollController.
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (context, index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {

  final int index;

  const _PinterestItem(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
