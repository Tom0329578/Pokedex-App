// To parse this JSON data, do
//
//     final pokedex = pokedexFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Pokedex> pokedexFromJson(String str) =>
    List<Pokedex>.from(json.decode(str).map((x) => Pokedex.fromJson(x)));

String pokedexToJson(List<Pokedex> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pokedex {
  Pokedex({
    required this.number,
    required this.name,
    required this.species,
    required this.types,
    required this.abilities,
    required this.eggGroups,
    required this.gender,
    required this.height,
    required this.weight,
    required this.family,
    required this.starter,
    required this.legendary,
    required this.mythical,
    required this.ultraBeast,
    required this.mega,
    required this.gen,
    required this.sprite,
    required this.description,
  });

  String number;
  String name;
  String species;
  List<String> types;
  Abilities abilities;
  List<String> eggGroups;
  List<dynamic> gender;
  String height;
  String weight;
  Family family;
  bool starter;
  bool legendary;
  bool mythical;
  bool ultraBeast;
  bool mega;
  int gen;
  String sprite;
  String description;

  factory Pokedex.fromJson(Map<String, dynamic> json) => Pokedex(
        number: json["number"],
        name: json["name"],
        species: json["species"],
        types: List<String>.from(json["types"].map((x) => x)),
        abilities: Abilities.fromJson(json["abilities"]),
        eggGroups: List<String>.from(json["eggGroups"].map((x) => x)),
        gender: List<dynamic>.from(json["gender"].map((x) => x)),
        height: json["height"],
        weight: json["weight"],
        family: Family.fromJson(json["family"]),
        starter: json["starter"],
        legendary: json["legendary"],
        mythical: json["mythical"],
        ultraBeast: json["ultraBeast"],
        mega: json["mega"],
        gen: json["gen"],
        sprite: json["sprite"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "species": species,
        "types": List<dynamic>.from(types.map((x) => x)),
        "abilities": abilities.toJson(),
        "eggGroups": List<dynamic>.from(eggGroups.map((x) => x)),
        "gender": List<dynamic>.from(gender.map((x) => x)),
        "height": height,
        "weight": weight,
        "family": family.toJson(),
        "starter": starter,
        "legendary": legendary,
        "mythical": mythical,
        "ultraBeast": ultraBeast,
        "mega": mega,
        "gen": gen,
        "sprite": sprite,
        "description": description,
      };
}

class Abilities {
  Abilities({
    required this.normal,
    required this.hidden,
  });

  List<String> normal;
  List<String> hidden;

  factory Abilities.fromJson(Map<String, dynamic> json) => Abilities(
        normal: List<String>.from(json["normal"].map((x) => x)),
        hidden: List<String>.from(json["hidden"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "normal": List<dynamic>.from(normal.map((x) => x)),
        "hidden": List<dynamic>.from(hidden.map((x) => x)),
      };
}

class Family {
  Family({
    required this.id,
    required this.evolutionStage,
    required this.evolutionLine,
  });

  int id;
  int evolutionStage;
  List<String> evolutionLine;

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        id: json["id"],
        evolutionStage: json["evolutionStage"],
        evolutionLine: List<String>.from(json["evolutionLine"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "evolutionStage": evolutionStage,
        "evolutionLine": List<dynamic>.from(evolutionLine.map((x) => x)),
      };
}
