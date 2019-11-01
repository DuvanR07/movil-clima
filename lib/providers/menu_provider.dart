import 'dart:convert';

import 'package:clima/models/item_menu_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {
  List<ItemMenu> opciones = [];

  _MenuProvider() {
    cargarData();
  }

  Future<List<ItemMenu>> cargarData() async {
    final respuesta = await rootBundle.loadString('data/menu_opcion.json');

    Map dataMap = json.decode(respuesta);
    print(dataMap['nombreApp']);
    opciones = new ItemMenus.fromJsonList(dataMap['opciones']).items;
    return opciones;
  }
}

final menuProvider = new _MenuProvider();
