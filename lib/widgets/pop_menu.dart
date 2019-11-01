import 'package:clima/models/item_menu_model.dart';
import 'package:clima/utils/icon_string_util.dart';
import 'package:flutter/material.dart';

class PopMenu extends StatelessWidget {
  final List<ItemMenu> menu;

  PopMenu({@required this.menu});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: _itemMenu(menu, context),
      ),
    );
  }

  Widget _itemMenu(List<ItemMenu> menu, BuildContext context) {
    return new PopupMenuButton<ItemMenu>(
      itemBuilder: (BuildContext context) {
        return menu.map((ItemMenu item) {
          return new PopupMenuItem(
            child: new Row(
              children: <Widget>[
                getIcon(item.icon),
                new Container(
                  width: 3,
                ),
                new Text(
                  item.texto,
                  style: TextStyle(color: Colors.black87),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            value: item,
            enabled: _rutaActual(context, item.ruta),
          );
        }).toList();
      },
      onSelected: (ItemMenu item) => _selectMenu(item, context),
      icon: Icon(
        Icons.more_vert,
        color: Colors.black54,
      ),
    );
  }

  bool _rutaActual(BuildContext context, ruta) {
    String actual = ModalRoute.of(context).settings.name;
    if (ruta == actual) {
      return false;
    }
    return true;
  }

  void _selectMenu(ItemMenu item, BuildContext context) async {
    switch (item.texto) {
      case "Ajustes":
        Navigator.pushNamed(context, 'ajustes');
        break;
      case "Ubicación":
        Navigator.pushNamed(context, 'ubicacion');

        break;
    }
  }
}
