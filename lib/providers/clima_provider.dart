import 'dart:convert';

import 'package:clima/models/clima_model.dart';
import 'package:http/http.dart' as http;

class ClimaProvider {
  String _appid = "fd1aa9d4f2419a2f6462415b39f2fac5";
  String _url = "api.openweathermap.org";
  String _lang = "es";
  String _units = "metric";

  Future<Clima> getClima(String lat, String lon) async {
    final url = Uri.http(_url, "data/2.5/weather", {
      'appid': _appid,
      'lang': _lang,
      'units': _units,
      'lat': lat,
      'lon': lon
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final dataClima = new Clima.fromJsonMap(decodeData);
    return dataClima;
  }
}
