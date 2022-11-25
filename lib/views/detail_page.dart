import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/views/output.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

int ListIndex = 0;

class _DetailsState extends State<Details> {
  double fontSize = 20;
  Pokedex currentPokemon = globalPoke![ListIndex];
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double imageWidth = 0;
    if (deviceWidth >= 800) {
      imageWidth = 450;
    } else {
      imageWidth = deviceWidth - 50;
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
        title: Text('Pokedex Entry: ${currentPokemon.number}',
            textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        shape:
            Border(bottom: BorderSide(color: Colors.grey.shade800, width: 6)),
        elevation: 5,
      ),
      body: SingleChildScrollView(
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
                      currentPokemon.name,
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('The ${currentPokemon.species} Pokemon',
                        textAlign: TextAlign.left),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: imageWidth,
                      child: Image.network(currentPokemon.sprite),
                      decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                          side:
                              BorderSide(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(70),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  children: [
                    Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                      if (currentPokemon.mythical) {
                        return Text(
                            'This is a Mythical Pokemon From Gen ${currentPokemon.gen}');
                      } else if (currentPokemon.legendary) {
                        return Text(
                            'This is a Legendary Pokemon From Gen ${currentPokemon.gen}');
                      } else if (currentPokemon.mega) {
                        return Text(
                            'This is a Mega Evolution From Gen ${currentPokemon.gen}');
                      } else if (currentPokemon.ultraBeast) {
                        return Text(
                            'This is an Ultra Beast From Gen ${currentPokemon.gen}');
                      } else if (currentPokemon.starter) {
                        return Text(
                            'This is a starter Pokemon From Gen ${currentPokemon.gen}');
                      } else {
                        return Text(
                            'This is a regular Pokemon From Gen ${currentPokemon.gen}');
                      }
                    }))
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  children: [
                    Expanded(child: Text(currentPokemon.description)),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  children: [
                    Expanded(
                      child: Text('Average weight: ${currentPokemon.weight}',
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Average height: ${currentPokemon.height}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  children: [
                    const Text(
                      'Types: ',
                      textAlign: TextAlign.left,
                    ),
                    for (String type in currentPokemon.types) ...[
                      if (currentPokemon.types.indexOf(type) ==
                          currentPokemon.types.length - 1)
                        Text('$type ')
                      else
                        Text('$type, ')
                    ]
                  ],
                ),
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
                    const Text(
                      '- Normal: ',
                      textAlign: TextAlign.left,
                    ),
                    for (String ability in currentPokemon.abilities.normal) ...[
                      if (currentPokemon.abilities.normal.indexOf(ability) ==
                          currentPokemon.abilities.normal.length - 1)
                        Text(ability)
                      else
                        Text('$ability, ')
                    ]
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '- Hidden: ',
                      textAlign: TextAlign.left,
                    ),
                    for (String ability in currentPokemon.abilities.hidden) ...[
                      if (currentPokemon.abilities.hidden.indexOf(ability) ==
                          currentPokemon.abilities.hidden.length - 1)
                        Text(ability)
                      else
                        Text('$ability, ')
                    ]
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
                  children: [
                    Text('- Family ID: ${currentPokemon.family.id}\r\n'
                        '- Amount of Stages: ${currentPokemon.family.evolutionLine.length}\r\n'
                        '- Current Evolution Stage: ${currentPokemon.family.evolutionStage}')
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
                      if (currentPokemon.family.evolutionLine.length == 3) {
                        return Text(
                            '- Stage 1: ${currentPokemon.family.evolutionLine[0]}\r\n'
                            '- Stage 2: ${currentPokemon.family.evolutionLine[1]}\r\n'
                            '- Stage 3: ${currentPokemon.family.evolutionLine[2]}');
                      } else if (currentPokemon.family.evolutionLine.length ==
                          2) {
                        return Text(
                            '- Stage 1: ${currentPokemon.family.evolutionLine[0]}\r\n'
                            '- Stage 2: ${currentPokemon.family.evolutionLine[1]}');
                      } else {
                        return Text(
                            '- Stage 1: ${currentPokemon.family.evolutionLine[0]}');
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
    );
  }
}
