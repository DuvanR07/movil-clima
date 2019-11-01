import 'dart:convert';

import 'package:clima/models/ciudad_model.dart';
import 'package:http/http.dart' as http;


class CiudadesProviders {
  String _token ="pk.eyJ1IjoiZHV2YW5yMDciLCJhIjoiY2p5eWh1cGpuMTdvNDNlbXNtYnY0aXBwNiJ9.oJHY10lngN9XEMLmTD0pCQ";
  String _url = "api.mapbox.com";
  String _language ="es-ES";
  String _limit = "10";

  Future<List<Ciudad>> getCiudades(String query) async{

    final  url = Uri.http(_url, "geocoding/v5/mapbox.places/$query.json",{
      'limit' : _limit,
      'access_token': _token,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final ciudades = new Ciudades.fromJsonList(decodeData['features']);
    return ciudades.items;
  }
}
