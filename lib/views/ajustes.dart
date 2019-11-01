import 'package:flutter/material.dart';

class Ajustes extends StatefulWidget {
  @override
  _AjustesState createState() => new _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          "Ajustes",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
          color: Colors.black54,
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: Text("Unidad de medida"),
            onTap: () {},
            subtitle: new Text(
              "ºC",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(height: 1.0),


          new ListTile(
            title: Text("Actualización automática"),
            onTap: () {},
            subtitle: new Text(
              "Cada 3 horas",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(height: 1.0),

          new ListTile(
            title: Text("Usar ubicación actual"),
            onTap: () {},
            subtitle: new Text(
              "Activado",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(height: 1.0,),

          new ListTile(
            title: Text("Notificaciones"),
            onTap: () {},
            subtitle: new Text(
              "Recibir notificaciones sobre cambios de clima",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: new Checkbox(value: true, onChanged: (val){}),
          ),
          Divider(height: 1.0),

        ],
        padding: EdgeInsets.only(right: 10.0,left: 10.0),
      ),
    );
  }
}
