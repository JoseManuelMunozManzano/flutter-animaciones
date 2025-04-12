// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Esto es lo que me tienen que mandar.
// Un icono y el callback a ejecutar cuando se pulse sobre el icono.
class PinterestButton {
  final GestureTapCallback onPressed;
  final IconData icon;

  PinterestButton({
    required this.onPressed,
    required this.icon,
  });
}

class PinterestMenu extends StatelessWidget {

  // final List<PinterestButton> items = [
  //   PinterestButton(onPressed: (){print('Icon pie_chart');}, icon: Icons.pie_chart),
  //   PinterestButton(onPressed: (){print('Icon search');}, icon: Icons.search),
  //   PinterestButton(onPressed: (){print('Icon notifications');}, icon: Icons.notifications),
  //   PinterestButton(onPressed: (){print('Icon supervised_user_circle');}, icon: Icons.supervised_user_circle),
  // ];

  final List<PinterestButton> items;
  final bool mostrar;

  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const PinterestMenu({
    super.key,
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black, 
    this.inactiveColor = Colors.blueGrey,
    required this.items,
  });

   @override
    Widget build(BuildContext context) {
      // Punto más alto que me interesa para instanciar mi provider.
      return ChangeNotifierProvider(
        create: (_) => _MenuModel(),
          child: AnimatedOpacity(
          opacity: mostrar ? 1 : 0,
          duration: Duration(milliseconds: 250),
          child: Builder(
            builder: (context) {
              Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
              Provider.of<_MenuModel>(context).activeColor = activeColor;
              Provider.of<_MenuModel>(context).inactiveColor = inactiveColor;

              return _PinterestMenuBackground(
                child: _MenuItems(items)
              );
            }
          ),
        ),
      );
    }
}

class _PinterestMenuBackground extends StatelessWidget {

  final Widget child;

  const _PinterestMenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {

    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ]
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  const _MenuItems(
    this.menuItems
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestMenuButton(i, menuItems[i]))
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  const _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {

    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final activeColor = Provider.of<_MenuModel>(context).activeColor;
    final inactiveColor = Provider.of<_MenuModel>(context).inactiveColor;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      // Por si en algunos dispositivos móviles no funciona bien el GestureDetector,
      // porque no reconoce bien el lugar, añadimos el behavior.
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: itemSeleccionado == index ? 35 : 25,
          color: itemSeleccionado == index ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => _itemSeleccionado;

  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }

  Color get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
  }

  Color get activeColor => _activeColor;

  set activeColor(Color color) {
    _activeColor = color;
  }

  Color get inactiveColor => _inactiveColor;

  set inactiveColor(Color color) {
    _inactiveColor = color;
  }
}
