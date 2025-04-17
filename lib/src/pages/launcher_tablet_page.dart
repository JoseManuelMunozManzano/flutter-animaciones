import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:design_app/src/theme/theme.dart';
import 'package:design_app/src/models/layout_model.dart';

import 'package:design_app/src/routes/routes.dart';

class LauncherTabletPage extends StatelessWidget {
  const LauncherTabletPage({super.key});

   @override
    Widget build(BuildContext context) {
      final appTheme = Provider.of<ThemeChanger>(context);
      final layoutModel = Provider.of<LayoutModel>(context);

      return Scaffold(
        appBar: AppBar(
          title: Text('Diseños en Flutter-Tablet'),
          backgroundColor: appTheme.currentTheme.colorScheme.primary,
        ),
        drawer: _MenuPrincipal(),
        body: Row(
          children: [
            SizedBox(
              width: 300,
              height: double.infinity,
              child: _ListaOpciones(),
            ),

            Container(
              width: 1,
              height: double.infinity,
              color: appTheme.darkTheme ? Colors.grey : appTheme.currentTheme.colorScheme.primary,
            ),

            Expanded(
              // layoutModel contiene la página que quiero mostrar.
              child: layoutModel.currentPage,
            )
          ],
        )
      );
    }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;    

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, i) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(
        // El Widget que se coloca al inicio
        leading: FaIcon(pageRoutes[i].icon, color: appTheme.colorScheme.primary),
        title: Text(pageRoutes[i].titulo),
        trailing: Icon(Icons.chevron_right, color: appTheme.colorScheme.primary),
        onTap: () {
          // Si hago esto quito la parte izquierda con las opciones disponibles.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => pageRoutes[i].page));
          final layoutModel = Provider.of<LayoutModel>(context, listen: false);
          layoutModel.currentPage = pageRoutes[i].page;
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);
    final primaryColor = appTheme.currentTheme.colorScheme.primary;

    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: SizedBox(
                width: double.infinity,
                height: 150,
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text('JM', style: TextStyle(fontSize: 50)),
                ),
              ),
            ),

            Expanded(child: _ListaOpciones()),

            ListTile(
              leading: Icon(Icons.lightbulb_outline, color: primaryColor),
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: appTheme.darkTheme,
                activeColor: primaryColor,
                onChanged: (value) => appTheme.darkTheme = value,
              ),
            ),

            SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child: ListTile(
                leading: Icon(Icons.add_to_home_screen, color: primaryColor),
                title: Text('Custom Theme'),
                trailing: Switch.adaptive(
                  value: appTheme.customTheme,
                  activeColor: primaryColor,
                  onChanged: (value) => appTheme.customTheme = value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
