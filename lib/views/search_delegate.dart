import 'package:clima/models/ciudad_model.dart';
import 'package:clima/providers/ciudades_providers.dart';
import 'package:clima/providers/clima_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clima/database/ciudadQuery.dart';

class DataSearch extends SearchDelegate<String> {
  final cuidadesProviders = new CiudadesProviders();

  @override
  List<Widget> buildActions(BuildContext context) {
    // accciones del appbar (icono)

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print("Leading icon press");
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    print("caso");
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: cuidadesProviders.getCiudades(query),
      builder: (BuildContext context, AsyncSnapshot<List<Ciudad>> snapshot) {
        if (snapshot.hasData) {
          final ciudades = snapshot.data;
          return ListView(
              children: ciudades.map((ciudad) {
            final listitle = ListTile(
                // leading: Icon(Icons.location_on),
                title: Text(
                  ciudad.nombre,
                  style: TextStyle(color: (Colors.blue)),
                ),
                subtitle: Text(ciudad.descripcion),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Lat: " + ciudad.lat,
                      style: TextStyle(fontSize: 10.0),
                    ),
                    Text(
                      "Long: " + ciudad.lon,
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                ),
                onTap: () => _getClima(context, ciudad));
            return Column(
              children: <Widget>[
                listitle,
                Divider(
                  height: 0.0,
                )
              ],
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<bool> _exiteCiudad(String id) async {
    final md_ciudad = new CiudadQuery();
    final res = await md_ciudad.getCiudad(id);
    //print("un dato : ${ciudad.id}");
    if (res==null) {
      return false;
    }
    return true;
  }

  void _getClima(BuildContext context, Ciudad ciudad) async {
    if (await _exiteCiudad(ciudad.id)) {
      print("esta ciudad ya se encuentra registrada");
    } else {
      final climaProvider = new ClimaProvider();
      final clima = await climaProvider.getClima(ciudad.lat, ciudad.lon);
      ciudad.addClima(clima);
      print("DVN: " + ciudad.clima);
      guardarCiudad(context, ciudad);
    }
  }

  void guardarCiudad(BuildContext context, Ciudad ciudad) async {
    var map = new Map<String, dynamic>();
    final query = new CiudadQuery();
    int result = await query.insertCiudad(ciudad);

    if (result != 0) {
      print("Guardado exitosamente");
      close(context, null);
      Navigator.pushNamed(context, 'ubicacion', arguments: ciudad);
    } else {
      //  showToast("Error al guardar el token", Colors.orange);
    }
  }
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(en_US)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "Buscar ciudades";
}
