import 'package:clima/views/Ajustes.dart';
import 'package:clima/views/Ubicacion.dart';
import 'package:clima/views/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:clima/views/Inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        CustomLocalizationDelegate()
      ],
      title: 'Clima',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: new Inicio(),
      initialRoute: 'inicio',
      routes: {
        'inicio': (context) => Inicio(),
        'ubicacion': (context) => Ubicacion(),
        'ajustes': (context) => Ajustes()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
