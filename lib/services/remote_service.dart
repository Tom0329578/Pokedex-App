import 'package:flutter_opdracht_7/models/post.dart';
import 'package:flutter_opdracht_7/views/home_page.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Pokedex>?> getPokemon(String PokeName) async {
    var client = http.Client();
    var uri = Uri.parse("https://pokeapi.glitch.me/v1/pokemon/$PokeName");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return pokedexFromJson(json);
    }
  }
}
