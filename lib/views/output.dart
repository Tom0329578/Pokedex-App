import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/models/Pokemon.dart';
import 'package:flutter_opdracht_7/services/remote_service.dart';
import 'package:flutter_opdracht_7/views/detail_page.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';
import 'package:flutter_opdracht_7/models/EvolutionChain.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  Pokedex? pokedex;
  Pokedex? tempPokedex;
  String? placeHolder;
  Pokemon? tempPokemon;
  Pokemon? pokemon;
  List<Variety>? tempVarieties;
  EvolutionChainFull? tempChain;
  EvolutionChainFull? chain;
  List<String?>? images;

  String pokemonName = textoutput;
  int number = 0;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData(pokemonName);
  }

  getData(String poke) async {
    tempPokedex = await RemoteServices().getPokedex(poke);
    if (tempPokedex != null) {
      setState(() {
        pokedex = tempPokedex;
        errormessage = ' ';
        number = pokedex!.id;
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
        title: Text('Pokedex Entry: $number', textAlign: TextAlign.center),
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
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      pokedex!.name,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text('ID: ${pokedex!.id}'),
                    onTap: () {
                      setState(() {});
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
