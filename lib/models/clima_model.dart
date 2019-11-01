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
  var weathers;
  String wind;

  Clima(
      {this.temp,
      this.pressure,
      this.humidity,
      this.temp_min,
      this.temp_max,
      this.weathers,
      this.wind});

  Clima.fromJsonMap(Map<String, dynamic> json) {
    temp       = json['main']['temp'].toString();
    pressure   = json['main']['pressure'].toString();
    humidity   = json['main']['humidity'].toString();
    temp_max   = json['main']['temp_max'].toString();
    temp_min   = json['main']['temp_min'].toString();
    weathers   = json['weather'];
    wind       = json['wind']['speed'].toString();
  }

    Clima.jsonToObjet(String data) {
   var clima = json.decode(data);
    temp       = clima['temp'].toString();
    pressure   = clima['pressure'].toString();
    humidity   = clima['humidity'].toString();
    temp_max   = clima['temp_max'].toString();
    temp_min   = clima['temp_min'].toString();
   // weathers   = json.decode(clima['weather']);
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
