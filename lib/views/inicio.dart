import 'package:clima/models/ciudad_model.dart';
import 'package:clima/models/item_menu_model.dart';
import 'package:clima/providers/menu_provider.dart';
import 'package:clima/widgets/pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:clima/views/BackWheater.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clima/views/page_view_item.dart';
import 'package:clima/models/ciudad_model.dart';
import 'package:clima/database/ciudadQuery.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => new _InicioState();
}

class _InicioState extends State<Inicio> {
  Ciudad ciudad = new Ciudad();
  final md_ciudad = new CiudadQuery();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //body: _ciudadesPage());
        body: new Stack(
      children: <Widget>[
     //   BackWheater(),
     _ciudadesPage(),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25.0),
              child: _menu(),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ],
    ));
  }

  Widget _menu() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      builder: (BuildContext context, AsyncSnapshot<List<ItemMenu>> snapshot) {
        final List<ItemMenu> dataMenu = snapshot.data;
        return PopMenu(menu: dataMenu);
      },
    );
  }

  Widget _ciudadesPage() {
    final paginas = new List<Widget>();

    return FutureBuilder(
        future: md_ciudad.getCiudades(),
         initialData: <Ciudad>[],
        builder: (BuildContext context, AsyncSnapshot<List<Ciudad>> snapshot) {
          List<Ciudad> data = snapshot.data;

          if (data.length == 0) return Center(child: Text("No se encontraron ciudades"));

          if (snapshot.hasData) {
            return PageView.builder(
              controller: PageController(initialPage: 0),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return new PageViewItem(
                  ciudad: data[i],
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

