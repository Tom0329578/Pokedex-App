import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/EvolutionChain.dart';
import 'package:flutter_opdracht_7/services/remote_service.dart';
import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/models/Pokemon.dart';
import 'package:flutter_opdracht_7/views/output.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

int ListIndex = 0;

class _DetailsState extends State<Details> {
  double fontSize = 20;
  Pokedex? currentPokedex;
  Pokemon? currentPokemon;
  EvolutionChainFull? currentChain;
  String? flavourText;
  String? genus;
  Pokedex? tempPokedex;
  String? placeHolder;
  Pokemon? tempPokemon;
  List<Variety>? tempVarieties;
  EvolutionChainFull? tempChain;
  double? weight = 0;
  double? height = 0;
  String pokemonName = textoutput;
  int number = 0;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData(pokemonName);
  }

  getData(String poke) async {
    tempPokedex = await RemoteServices().getPokedex(poke);
    if (tempPokedex != null) {
      setState(() {
        currentPokedex = tempPokedex;
        errormessage = ' ';
        number = currentPokedex!.id;
        tempVarieties = tempPokedex!.varieties;
      });
    } else {
      setState(() {
        error404 = true;
        errormessage = "Error 404\r\nYour Pokemon could not be found";
      });
      Navigator.pop(context);
    }
    tempPokemon = await RemoteServices()
        .getPokemon(currentPokedex?.varieties[0].pokemon.url);
    if (tempPokemon != null) {
      setState(() {
        currentPokemon = tempPokemon;
        placeHolder = tempPokemon?.sprites.other?.officialArtwork.frontDefault;
      });
    } else {
      setState(() {
        error404 = true;
        errormessage = "Error 404\r\nYour Pokemon could not be found";
      });
      Navigator.pop(context);
    }
    tempChain = await RemoteServices()
        .getEvolution(currentPokedex!.evolutionChain!.url);
    if (tempChain != null) {
      setState(() {
        currentChain = tempChain;
      });
    } else {
      Navigator.pop(context);
    }
    if (currentChain != null &&
        currentPokemon != null &&
        currentPokedex != null) {
      setState(() {
        weight = currentPokemon!.weight / 10;
        height = currentPokemon!.height / 10;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double imageWidth = 0;

    if (deviceWidth >= 800) {
      imageWidth = 450;
    } else {
      imageWidth = deviceWidth - 50;
    }

    if (isLoaded == true) {
      for (var entry in currentPokedex!.flavorTextEntries) {
        if (entry.language.name == 'en') {
          flavourText = entry.flavorText.replaceAll("\n", " ");
        }
      }
      for (var tempGenus in currentPokedex!.genera) {
        if (tempGenus.language.name == 'en') {
          genus = tempGenus.genus;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w700),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${currentPokedex?.name}',
                        style: const TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text('The $genus')],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: imageWidth,
                        decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(
                            side: BorderSide(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(70),
                          ),
                        ),
                        child: Image.network('$placeHolder'),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    children: [
                      Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                        if (currentPokedex!.isMythical) {
                          return Text(
                              'This is a Mythical Pokemon From ${currentPokedex!.generation.name.toUpperCase()}');
                        } else if (currentPokedex!.isLegendary) {
                          return Text(
                              'This is a Legendary Pokemon From ${currentPokedex!.generation.name.toUpperCase()}');
                        } else {
                          return Text(
                              'This is a regular Pokemon From ${currentPokedex!.generation.name.toUpperCase()}');
                        }
                      }))
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Row(
                    children: [
                      Expanded(child: Text('$flavourText')),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Average weight: $weight Kg",
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Average height: $height M",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Row(children: [
                    const Text(
                      'Types: ',
                      textAlign: TextAlign.left,
                    ),
                    for (Type type in currentPokemon!.types) ...[
                      if (type.slot == 1)
                        Text('${type.type.name}, ')
                      else
                        Text('${type.type.name}')
                    ],
                  ]),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Row(
                    children: const [
                      Text(
                        'Abilities',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
                  Row(
                    children: [
                      Text(
                        getAbilities(currentPokemon!.abilities),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    children: const [
                      Text(
                        'Family',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 5)),
                  Row(
                    children: [Text('- Family ID: ${currentChain?.id}')],
                  ),
                  Row(
                    children: [
                      if (currentChain?.chain.species.name ==
                          currentPokemon!.species.name) ...[
                        const Text('- Current Stage: 1')
                      ] else if (currentChain?.chain.evolvesTo[0].species ==
                          currentPokemon!.species.name) ...[
                        const Text('- Current Stage: 2')
                      ] else ...[
                        const Text('- Current Stage: 3')
                      ]
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    children: const [
                      Text(
                        'Evolution Line',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                        if (currentChain!.chain.evolvesTo.isEmpty) {
                          return Text(
                              '- Stage 1: ${currentChain!.chain.species.name}');
                        } else if (currentChain!
                            .chain.evolvesTo[0].evolvesTo.isEmpty) {
                          return Text(
                              '- Stage 1: ${currentChain!.chain.species.name}\r\n'
                              '- Stage 2: ${currentChain!.chain.evolvesTo[0].species.name}');
                        } else {
                          return Text(
                              '- Stage 1: ${currentChain!.chain.species.name}\r\n'
                              '- Stage 2: ${currentChain!.chain.evolvesTo[0].species.name}\r\n'
                              '- Stage 3: ${currentChain!.chain.evolvesTo[0].evolvesTo[0].species.name}');
                        }
                      })),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String getAbilities(List<Ability> List) {
  String returnString = '';
  if (List.isNotEmpty) {
    for (Ability ability in List) {
      if (ability.isHidden) {
        returnString += '- Hidden: ${ability.ability.name}';
      } else {
        returnString += '- Normal: ${ability.ability.name}\r\n';
      }
    }
  } else {
    returnString = 'None';
  }
  return returnString;
}
