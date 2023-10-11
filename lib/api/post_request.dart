import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gamelib_mob/helpers/game_class.dart';

Future<List<GameInfo>> getGameInfo(token1, search) async {
  String token = token1;
  String searchInfo = search;
  List<dynamic> ids;
  List<dynamic> gameNamesTemp;
  List<dynamic> gameCoverTemp;
  List<GameInfo> gameNames = [];

  final response1 = await http.post(Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('search "$searchInfo"; limit 10;'));
  ids = jsonDecode(response1.body);

  if (ids.isEmpty) {
    throw Exception('No Games Found');
  }
  String id = '';
  for (var i = 0; i < ids.length; i++) {
    var map = HashMap.from(ids[i]);
    map.forEach((key, value) {
      id = '$id$value,';
    });
  }
  id = id.substring(0, id.length - 1);

  final responseCover = await http.post(
      Uri.parse('https://api.igdb.com/v4/covers'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('fields url; where game = ($id);'));
  gameCoverTemp = jsonDecode(responseCover.body);

  final response = await http.post(Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('fields name; where id = ($id);'));
  gameNames.clear();
  gameNamesTemp = jsonDecode(response.body);
  print(gameCoverTemp.length);
  print(gameNamesTemp.length);
  for (var i = 0; i < gameNamesTemp.length; i++) {
    GameInfo createdGame = GameInfo(
      gameID: '',
      name: "",
      cover: Image.asset('assets/images/test.jpg'),
    );
    var mapNames = HashMap.from(gameNamesTemp[i]);
    if (i < gameCoverTemp.length) {
      var mapCovers = HashMap.from(gameCoverTemp[i]);
      createdGame.cover = Image.network('https:' + mapCovers['url']);
    }

    createdGame.name = mapNames['name'];
    createdGame.gameID = mapNames['id'].toString();
    gameNames.add(createdGame);
    print(gameNames.length);
  }

  return gameNames;
}