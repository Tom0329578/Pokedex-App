import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/models/Pokemon.dart';
import 'package:flutter_opdracht_7/services/remote_service.dart';
import 'package:flutter_opdracht_7/views/detail_page.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';
import 'package:flutter_opdracht_7/models/EvolutionChain.dart';
import 'package:flutter_opdracht_7/models/pokemonTypes.dart';
import 'package:flutter_opdracht_7/models/TypeList.dart';

class TypeOutput extends StatefulWidget {
  const TypeOutput({Key? key}) : super(key: key);

  @override
  State<TypeOutput> createState() => _TypeOutputState();
}

class _TypeOutputState extends State<TypeOutput> {
  PokemonTypes? pokemonTypes;
  TypeList? typeList;
  List<String>? types;
  List<POKEMON> list = [];
  int number = 0;
  var isLoaded = false;
  var dropDownValue;

  @override
  void initState() {
    super.initState();
    getData(type);
  }

  getData(String? type) async {
    pokemonTypes = await RemoteServices().getPokemonTypes(type!);
    if (pokemonTypes != null) {
      setState(() {
        errormessage = ' ';
        list = pokemonTypes!.pokemon;
        isLoaded = true;
      });
    } else {
      setState(() {
        error404 = true;
        errormessage = "Error 404\r\nYour Pokemon could not be found";
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Pokedex Entries: $type', textAlign: TextAlign.center),
        backgroundColor: Colors.red.shade700,
        shape:
            Border(bottom: BorderSide(color: Colors.grey.shade800, width: 6)),
        elevation: 5,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      pokemonTypes!.pokemon[index].pokemon.name,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text(
                        'ID: ${pokemonTypes?.pokemon[index].pokemon.url.split('/')[6]}'),
                    onTap: () {
                      setState(() {
                        textoutput = pokemonTypes!.pokemon[index].pokemon.name;
                        ListIndex = index;
                      });
                      Navigator.of(context).push(_routeDetails());
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              );
            }),
      ),
    );
  }
}

Route _routeDetails() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Details(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
