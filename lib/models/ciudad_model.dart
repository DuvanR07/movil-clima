import 'dart:convert';
import 'package:clima/models/clima_model.dart';

class Ciudades {
  List<Ciudad> items = new List();

  Ciudades();

  Ciudades.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final ciudad = new Ciudad.fromJsonMap(item);
      items.add(ciudad);
    }
  }
}

class Ciudad {
  String id;
  String nombre;
  String descripcion;
  String lat;
  String lon;
  String clima;
  String fecha;

  static String tableName = 'ciudad';
  static String idName = '_id';
  static String nombreName = 'nombre';
  static String descripcionName = 'descripcion';
  static String latName = 'lat';
  static String lonName = 'lon';
  static String climaName = 'clima';
  static String fechaName = 'fecha';

  Ciudad(
      {this.id, this.nombre, this.descripcion, this.lat, this.lon, this.clima});

  Ciudad.fromJsonMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nombre = json['text'];
    this.descripcion = json['place_name'];
    this.lat = json['geometry']['coordinates'][1].toString();
    this.lon = json['geometry']['coordinates'][0].toString();
  }


    Ciudad.fromMapObject(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.nombre = json['nombre'];
    this.descripcion = json['descripcion'];
    this.lat = json['lat'];
    this.lon = json['lon'];
    this.clima = json['clima'];
    this.fecha = json['fecha'];
  }

  void addClima(Clima clima) {
    this.clima = json.encode(clima.toJSON());
    this.fecha = DateTime.now().millisecondsSinceEpoch.toString();
 
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map['_id'] = id;
    }
    map['nombre'] = nombre;
    map['descripcion'] = descripcion;
    map['lat'] = lat;
    map['lon'] = lon;
    map['clima'] = clima;
    map['fecha'] = fecha;
    return map;
  }
}
