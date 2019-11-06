import 'package:clima/models/ciudad_model.dart';
import 'package:clima/views/backWheater.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageViewItem extends StatelessWidget {
  final Ciudad ciudad;

  PageViewItem({@required this.ciudad});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          new BackWheater(),
          new ListView(children: <Widget>[
            new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    //  _menu(),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
                new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    new Text(
                      ciudad.nombre,
                      style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                new Text(
                  "Parcialmente nublado",
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                new Container(
                  height: 150.0,
                ),
                new Row(
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Icon(
                          FontAwesomeIcons.cloudSun,
                          color: Colors.white,
                          size: 80.0,
                        ),
                        new Text(
                          "Sencacion termica",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    new Row(
                      children: <Widget>[
                        new Text(
                          "13",
                          style:
                              TextStyle(color: Colors.white, fontSize: 130.0),
                        ),
                        new Text(
                          "ºC",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
            new Container(
              height: 60.0,
            ),
            new Row(
              children: <Widget>[
                new Icon(
                  FontAwesomeIcons.cloudMoon,
                  color: Colors.grey,
                  size: 50.0,
                ),
                new Icon(
                  FontAwesomeIcons.cloudRain,
                  color: Colors.grey,
                  size: 50.0,
                ),
                new Icon(
                  FontAwesomeIcons.cloudMoonRain,
                  color: Colors.grey,
                  size: 50.0,
                ),
                new Icon(
                  FontAwesomeIcons.cloudSun,
                  color: Colors.grey,
                  size: 50.0,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ], padding: new EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0)),
        ],
      ),
    );
  }
}
