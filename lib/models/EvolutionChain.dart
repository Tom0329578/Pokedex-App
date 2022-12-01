import 'dart:convert';

EvolutionChainFull evolutionChainFromJson(String str) =>
    EvolutionChainFull.fromJson(json.decode(str));

String evolutionChainToJson(EvolutionChainFull data) =>
    json.encode(data.toJson());

class EvolutionChainFull {
  EvolutionChainFull({
    required this.babyTriggerItem,
    required this.chain,
    required this.id,
  });

  dynamic babyTriggerItem;
  Chain chain;
  int id;

  factory EvolutionChainFull.fromJson(Map<String, dynamic> json) =>
      EvolutionChainFull(
        babyTriggerItem: json["baby_trigger_item"],
        chain: Chain.fromJson(json["chain"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "baby_trigger_item": babyTriggerItem,
        "chain": chain.toJson(),
        "id": id,
      };
}

class Chain {
  Chain({
    required this.evolutionDetails,
    required this.evolvesTo,
    required this.isBaby,
    required this.species,
  });

  List<EvolutionDetail> evolutionDetails;
  List<Chain> evolvesTo;
  bool isBaby;
  Species species;

  factory Chain.fromJson(Map<String, dynamic> json) => Chain(
        evolutionDetails: List<EvolutionDetail>.from(
            json["evolution_details"].map((x) => EvolutionDetail.fromJson(x))),
        evolvesTo:
            List<Chain>.from(json["evolves_to"].map((x) => Chain.fromJson(x))),
        isBaby: json["is_baby"],
        species: Species.fromJson(json["species"]),
      );

  Map<String, dynamic> toJson() => {
        "evolution_details":
            List<dynamic>.from(evolutionDetails.map((x) => x.toJson())),
        "evolves_to": List<dynamic>.from(evolvesTo.map((x) => x.toJson())),
        "is_baby": isBaby,
        "species": species.toJson(),
      };
}

class EvolutionDetail {
  EvolutionDetail({
    required this.gender,
    required this.heldItem,
    required this.item,
    required this.knownMove,
    required this.knownMoveType,
    required this.location,
    required this.minAffection,
    required this.minBeauty,
    required this.minHappiness,
    required this.minLevel,
    required this.needsOverworldRain,
    required this.partySpecies,
    required this.partyType,
    required this.relativePhysicalStats,
    required this.timeOfDay,
    required this.tradeSpecies,
    required this.trigger,
    required this.turnUpsideDown,
  });

  dynamic gender;
  dynamic heldItem;
  dynamic item;
  dynamic knownMove;
  dynamic knownMoveType;
  dynamic location;
  dynamic minAffection;
  dynamic minBeauty;
  dynamic minHappiness;
  int? minLevel;
  bool needsOverworldRain;
  dynamic partySpecies;
  dynamic partyType;
  dynamic relativePhysicalStats;
  String timeOfDay;
  dynamic tradeSpecies;
  Species trigger;
  bool turnUpsideDown;

  factory EvolutionDetail.fromJson(Map<String, dynamic> json) =>
      EvolutionDetail(
        gender: json["gender"],
        heldItem: json["held_item"],
        item: json["item"],
        knownMove: json["known_move"],
        knownMoveType: json["known_move_type"],
        location: json["location"],
        minAffection: json["min_affection"],
        minBeauty: json["min_beauty"],
        minHappiness: json["min_happiness"],
        minLevel: json["min_level"],
        needsOverworldRain: json["needs_overworld_rain"],
        partySpecies: json["party_species"],
        partyType: json["party_type"],
        relativePhysicalStats: json["relative_physical_stats"],
        timeOfDay: json["time_of_day"],
        tradeSpecies: json["trade_species"],
        trigger: Species.fromJson(json["trigger"]),
        turnUpsideDown: json["turn_upside_down"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "held_item": heldItem,
        "item": item,
        "known_move": knownMove,
        "known_move_type": knownMoveType,
        "location": location,
        "min_affection": minAffection,
        "min_beauty": minBeauty,
        "min_happiness": minHappiness,
        "min_level": minLevel,
        "needs_overworld_rain": needsOverworldRain,
        "party_species": partySpecies,
        "party_type": partyType,
        "relative_physical_stats": relativePhysicalStats,
        "time_of_day": timeOfDay,
        "trade_species": tradeSpecies,
        "trigger": trigger.toJson(),
        "turn_upside_down": turnUpsideDown,
      };
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
