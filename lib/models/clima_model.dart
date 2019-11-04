import 'dart:convert';
class Weathers {
  List<Weather> items = new List();

  Weathers();

  Weathers.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var i = 0; i < jsonList.length; i++) {
      final weather = new Weather.fromJsonMap(jsonList[i]);
      items.add(weather);
    }
  }
}

class Weather {
  String id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'].toString();
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clima {
  String temp;
  String pressure;
  String humidity;
  String temp_max;
  String temp_min;
  String weathers;
  String wind;

  Clima(
      {this.temp,
      this.pressure,
      this.humidity,
      this.temp_min,
      this.temp_max,
      this.weathers,
      this.wind});

  Clima.fromJsonMap(Map<String, dynamic> data) {
    temp       = data['main']['temp'].toString();
    pressure   = data['main']['pressure'].toString();
    humidity   = data['main']['humidity'].toString();
    temp_max   = data['main']['temp_max'].toString();
    temp_min   = data['main']['temp_min'].toString();
    weathers   = json.encode(data['weather']); // es el nombre de la propiedad del json que viene desde internet
    wind       = data['wind']['speed'].toString();
  }

    Clima.jsonToObjet(String data) {
   var clima = json.decode(data);
    temp       = clima['temp'].toString();
    pressure   = clima['pressure'].toString();
    humidity   = clima['humidity'].toString();
    temp_max   = clima['temp_max'].toString();
    temp_min   = clima['temp_min'].toString();
    weathers   = clima['weathers'].toString();
    wind       = clima['wind'];
  }

   toJSON() => {
        'temp'       : temp,
        'pressure'   : pressure,
        'humidity'   : humidity,
        'temp_max'   : temp_max,
        'temp_min'   : temp_min,
        'weathers'   : weathers,
        'wind'       : wind
      };
}
