import 'package:flutter/material.dart';

class ItemMenu {
  String texto;
  String icon;
  String ruta;

  ItemMenu({this.texto, this.icon, this.ruta});

  ItemMenu.fromMap(Map data) {
    texto = data['texto'];
    icon = data['icon'];
    ruta =  data['ruta'];
  }
}


class ItemMenus {
  List<ItemMenu> items = new List();

  ItemMenus();

  ItemMenus.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final menu = new ItemMenu.fromMap(item);
      items.add(menu);
    }
  }
}