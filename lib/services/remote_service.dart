import 'package:flutter_opdracht_7/models/Pokedex.dart';
import 'package:flutter_opdracht_7/models/Pokemon.dart';
import 'package:flutter_opdracht_7/models/EvolutionChain.dart';
import 'package:flutter_opdracht_7/models/pokemonTypes.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';
import 'package:flutter_opdracht_7/models/TypeList.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<Pokedex?> getPokedex(String PokeName) async {
    var client = http.Client();
    var uri = Uri.parse("https://pokeapi.co/api/v2/pokemon-species/$PokeName");
    var response = await client.get(uri);
    statuscode = response.statusCode.toString();
    if (response.statusCode == 200) {
      var json = response.body;
      return pokedexFromJson(json);
    }
  }

  Future<Pokemon?> getPokemon(String? url) async {
    var client = http.Client();
    var uri = Uri.parse(url!);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return pokemonFromJson(json);
    }
  }

  Future<EvolutionChainFull?> getEvolution(String chainUrl) async {
    var client = http.Client();
    var uri = Uri.parse(chainUrl);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return evolutionChainFromJson(json);
    }
  }

  Future<PokemonTypes?> getPokemonTypes(String type) async {
    var client = http.Client();
    var uri = Uri.parse('https://pokeapi.co/api/v2/type/$type');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return welcomeFromJson(json);
    }
  }

  Future<TypeList?> getTypeList() async {
    var client = http.Client();
    var uri = Uri.parse('https://pokeapi.co/api/v2/type');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return typeListFromJson(json);
    }
  }
}
