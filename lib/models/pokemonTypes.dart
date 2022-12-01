// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PokemonTypes welcomeFromJson(String str) =>
    PokemonTypes.fromJson(json.decode(str));

String welcomeToJson(PokemonTypes data) => json.encode(data.toJson());

class PokemonTypes {
  PokemonTypes({
    required this.damageRelations,
    required this.gameIndices,
    required this.generation,
    required this.id,
    required this.moveDamageClass,
    required this.moves,
    required this.name,
    required this.names,
    required this.pastDamageRelations,
    required this.pokemon,
  });

  DamageRelations damageRelations;
  List<GameIndex> gameIndices;
  Generation generation;
  int id;
  Generation moveDamageClass;
  List<Generation> moves;
  String name;
  List<Name> names;
  List<PastDamageRelation> pastDamageRelations;
  List<POKEMON> pokemon;

  factory PokemonTypes.fromJson(Map<String, dynamic> json) => PokemonTypes(
        damageRelations: DamageRelations.fromJson(json["damage_relations"]),
        gameIndices: List<GameIndex>.from(
            json["game_indices"].map((x) => GameIndex.fromJson(x))),
        generation: Generation.fromJson(json["generation"]),
        id: json["id"],
        moveDamageClass: Generation.fromJson(json["move_damage_class"]),
        moves: List<Generation>.from(
            json["moves"].map((x) => Generation.fromJson(x))),
        name: json["name"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
        pastDamageRelations: List<PastDamageRelation>.from(
            json["past_damage_relations"]
                .map((x) => PastDamageRelation.fromJson(x))),
        pokemon:
            List<POKEMON>.from(json["pokemon"].map((x) => POKEMON.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "damage_relations": damageRelations.toJson(),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "generation": generation.toJson(),
        "id": id,
        "move_damage_class": moveDamageClass.toJson(),
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
        "past_damage_relations":
            List<dynamic>.from(pastDamageRelations.map((x) => x.toJson())),
        "pokemon": List<dynamic>.from(pokemon.map((x) => x.toJson())),
      };
}

class DamageRelations {
  DamageRelations({
    required this.doubleDamageFrom,
    required this.doubleDamageTo,
    required this.halfDamageFrom,
    required this.halfDamageTo,
    required this.noDamageFrom,
    required this.noDamageTo,
  });

  List<Generation> doubleDamageFrom;
  List<Generation> doubleDamageTo;
  List<Generation> halfDamageFrom;
  List<Generation> halfDamageTo;
  List<dynamic> noDamageFrom;
  List<dynamic> noDamageTo;

  factory DamageRelations.fromJson(Map<String, dynamic> json) =>
      DamageRelations(
        doubleDamageFrom: List<Generation>.from(
            json["double_damage_from"].map((x) => Generation.fromJson(x))),
        doubleDamageTo: List<Generation>.from(
            json["double_damage_to"].map((x) => Generation.fromJson(x))),
        halfDamageFrom: List<Generation>.from(
            json["half_damage_from"].map((x) => Generation.fromJson(x))),
        halfDamageTo: List<Generation>.from(
            json["half_damage_to"].map((x) => Generation.fromJson(x))),
        noDamageFrom: List<dynamic>.from(json["no_damage_from"].map((x) => x)),
        noDamageTo: List<dynamic>.from(json["no_damage_to"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "double_damage_from":
            List<dynamic>.from(doubleDamageFrom.map((x) => x.toJson())),
        "double_damage_to":
            List<dynamic>.from(doubleDamageTo.map((x) => x.toJson())),
        "half_damage_from":
            List<dynamic>.from(halfDamageFrom.map((x) => x.toJson())),
        "half_damage_to":
            List<dynamic>.from(halfDamageTo.map((x) => x.toJson())),
        "no_damage_from": List<dynamic>.from(noDamageFrom.map((x) => x)),
        "no_damage_to": List<dynamic>.from(noDamageTo.map((x) => x)),
      };
}

class Generation {
  Generation({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class GameIndex {
  GameIndex({
    required this.gameIndex,
    required this.generation,
  });

  int gameIndex;
  Generation generation;

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        generation: Generation.fromJson(json["generation"]),
      );

  Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "generation": generation.toJson(),
      };
}

class Name {
  Name({
    required this.language,
    required this.name,
  });

  Generation language;
  String name;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        language: Generation.fromJson(json["language"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language.toJson(),
        "name": name,
      };
}

class PastDamageRelation {
  PastDamageRelation({
    required this.damageRelations,
    required this.generation,
  });

  DamageRelations damageRelations;
  Generation generation;

  factory PastDamageRelation.fromJson(Map<String, dynamic> json) =>
      PastDamageRelation(
        damageRelations: DamageRelations.fromJson(json["damage_relations"]),
        generation: Generation.fromJson(json["generation"]),
      );

  Map<String, dynamic> toJson() => {
        "damage_relations": damageRelations.toJson(),
        "generation": generation.toJson(),
      };
}

class POKEMON {
  POKEMON({
    required this.pokemon,
    required this.slot,
  });

  Generation pokemon;
  int slot;

  factory POKEMON.fromJson(Map<String, dynamic> json) => POKEMON(
        pokemon: Generation.fromJson(json["pokemon"]),
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "pokemon": pokemon.toJson(),
        "slot": slot,
      };
}
