import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';

class SliverListPage extends StatelessWidget {
  const SliverListPage({super.key});

   @override
    Widget build(BuildContext context) {
      return Scaffold(
        // body: _ListaTareas()
        // body: _Titulo(),
        body: Stack(
          children: [
            _MainScroll(),
            Positioned(
              bottom: 0,
              right: 0,
              child: _BotonNewList()
            ),
          ],
        ),
      );
    }
}

class _BotonNewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final appTheme = Provider.of<ThemeChanger>(context);

    return SizedBox(
      width: size.width * 0.9,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.darkTheme ? appTheme.currentTheme.colorScheme.primary : Color(0xffED6762),
          foregroundColor: appTheme.currentTheme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
          )
        ),
        onPressed: () {},
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          )
        ),
      )
    );
  }
}

class _MainScroll extends StatelessWidget {

  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    // El CustomScrollView recibe slivers.
    return CustomScrollView(
      slivers: [
        // Ejemplo de SliverAppBar.
        // NO lo vamos a usar porque lo que tenemos nosostros es un Sliver personalizado.
        // SliverAppBar(
        //   floating: true,
        //   elevation: 0,
        //   backgroundColor: Colors.red,
        //   title: _Titulo(),
        // ),

        // Este es nuestro sliver personalizado
        SliverPersistentHeader(
          // Para que al mover el listview hacia abajo aparezca el menú.
          floating: true,
          delegate: _SliverCustomHeaderDelegate(
            minHeight: 190,
            maxHeight: 200,
            child: Container(
              alignment: Alignment.centerLeft,
              color: appTheme.scaffoldBackgroundColor,
              child: _Titulo(),
            )
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate([
            ...items,
            SizedBox(height: 100),
          ])
        )
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {

  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
           minHeight != oldDelegate.minHeight ||
           child != oldDelegate.child;
  }

}

class _Titulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 0),
          child: Text('New',
             style: TextStyle(
              color: appTheme.darkTheme ? Colors.grey : Color(0xff532128),
              fontSize: 50
            )
          ),
        ),
        Stack(
          children: [
            SizedBox(width: 100),
            Positioned(
              bottom: 8,
              child: Container(
                width: 150,
                height: 8,
                color: appTheme.darkTheme ? Colors.grey : Color(0xffF7CDD5),
              ),
            ),

            Container(
              child: Text('List', style: TextStyle(color: Color(0xffD93A30), fontSize: 50, fontWeight: FontWeight.bold)),
            ),
          ],
        )
      ],
    );
  }
}

class _ListaTareas extends StatelessWidget {

  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => items[index],
    );
  }
}

class _ListItem extends StatelessWidget {

  final String titulo;
  final Color color;

  const _ListItem(
    this.titulo, 
    this.color
  );

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(30),
      height: 130,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appTheme.darkTheme ? Colors.grey : color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        titulo,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20
        )
      ),
    );
  }
}
