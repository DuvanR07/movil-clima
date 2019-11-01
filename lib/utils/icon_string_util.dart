import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'settings'    : Icons.settings,
  'location_on' : Icons.location_on
};
Icon getIcon(String nombreIcono) {
  return Icon(
    _icons[nombreIcono],
    color: Colors.black54,
  );
}
