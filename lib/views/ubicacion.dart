import 'dart:convert';

import 'package:clima/models/clima_model.dart';
import 'package:clima/models/item_menu_model.dart';
import 'package:clima/providers/menu_provider.dart';
import 'package:clima/widgets/pop_menu.dart';
import 'package:intl/intl.dart';
import 'package:clima/database/ciudadQuery.dart';
import 'package:clima/models/ciudad_model.dart';
import 'package:clima/views/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


class Ubicacion extends StatefulWidget {
  @override
  _UbicacionState createState() => new _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  Ciudad ciudad = new Ciudad();
  final md_ciudad = new CiudadQuery();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null); //util para la fecha en español
    print(menuProvider.opciones);
  }

  @override
  Widget build(BuildContext context) {
    ciudad = ModalRoute.of(context).settings.arguments;
    Intl.defaultLocale = 'es';

    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          "Ubicación",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, 'inicio'),
          color: Colors.black54,
        ),
        actions: <Widget>[_menu()],
      ),
      body: _lista(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
        child: Icon(Icons.add),
        elevation: 1.0,
      ),
    );

  }

  //METODOS 

  Widget _lista() {
    return FutureBuilder(
      future: md_ciudad.getCiudades(),
      initialData: <Ciudad>[],
      builder: (BuildContext context, AsyncSnapshot<List<Ciudad>> snapshot) {
        List<Ciudad> data = snapshot.data;

        if (data.length == 0)
          return Center(child: Text("No se encontraron ciudades"));

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direccion) {
                  final res = md_ciudad.deleteCiudad(data[index].id);
                },
                background: Container(
                  color: Colors.red,
                  child: Center(
                      child: Text(
                    "Eliminar...",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: _item(data[index]),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(color: Colors.grey[350]),
                    ),
                    Divider(
                      height: 1.0,
                    )
                  ],
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _item(Ciudad data) {
    Clima clima = new Clima();
    clima = Clima.jsonToObjet(data.clima);
    var fecha = new DateTime.fromMillisecondsSinceEpoch(int.parse(data.fecha));
    var formatter = new DateFormat("EEE d 'de' MMMM yyyy hh:mm aaa ");
    final weathers = Weathers.fromJsonList(json.decode(clima.weathers));
    final weat = weathers.items[0];
    return ListTile(
      title: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            size: 15.0,
          ),
          Flexible (child: Text(data.nombre, overflow: TextOverflow.fade),)
     
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data.descripcion),
          Text(
            formatter.format(fecha),
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      trailing: new Column(
        children: <Widget>[
          new Wrap(
            children: <Widget>[
              Container(
                child: FadeInImage(
                  image: NetworkImage(
                    "https://openweathermap.org/img/wn/${weat.icon}@2x.png",
                  ),
                  placeholder: AssetImage(
                      'assets/img/loader.gif'),
                  fit: BoxFit.cover,
                ),
                height: 40.0,
              ),
              Text(
                "${clima.temp}º",
                style: TextStyle(fontSize: 20.0, color: Colors.black54),
              )
            ],
            alignment: WrapAlignment.spaceBetween,
          ),
          new Text("${clima.temp_min}º / ${clima.temp_max}º")
        ],
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
      onTap: () {},
    );
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
}
