import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/services/remote_service.dart';
import 'package:flutter_opdracht_7/views/detail_page.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  @override
  State<Output> createState() => _OutputState();
}

List<Pokedex>? globalPoke;

class _OutputState extends State<Output> {
  List<Pokedex>? pokemons;
  List<Pokedex>? TempPokemons;
  String pokemon = textoutput;
  String number = '';
  var Loaded = false;

  @override
  void initState() {
    super.initState();
    getData(pokemon);
  }

  getData(String poke) async {
    TempPokemons = await RemoteServices().getPokemon(poke);
    if (TempPokemons != null) {
      setState(() {
        pokemons = TempPokemons;
        Loaded = true;
        errormessage = ' ';
        number = pokemons![0].number;
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
            pokemons?.clear();
            TempPokemons?.clear();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Pokedex Entry: $number', textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        shape:
            Border(bottom: BorderSide(color: Colors.grey.shade800, width: 6)),
        elevation: 5,
      ),
      body: Visibility(
        visible: Loaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: pokemons?.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    shape: BeveledRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Image.network(pokemons![index].sprite),
                    title: Text(
                      pokemons![index].name,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text('ID: ${pokemons![index].number}'),
                    onTap: () {
                      setState(() {
                        ListIndex = index;
                        globalPoke = pokemons;
                      });
                      Navigator.of(context).push(_createRoute());
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

Route _createRoute() {
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
