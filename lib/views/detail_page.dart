import 'package:flutter/material.dart';
import 'package:flutter_opdracht_7/models/post.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: DefaultTextStyle(
            style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      currentPokemon.name,
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  children: [
                    Expanded(child: Text(currentPokemon.description)),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 30)),
                Row(
                  children: [
                    Text('Gewicht: ${currentPokemon.weight}',
                        textAlign: TextAlign.left),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: [
                    Text(
                      'Lengte: ${currentPokemon.height}',
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
