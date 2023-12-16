import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gamelib_mob/helpers/game_info.dart';

Future<List<GameInfo>> getGameInfo(apiToken, search) async {
  String token = apiToken;
  String searchInfo = search;
  List<dynamic> ids;
  List<dynamic> gameNamesTemp;
  List<dynamic> gameCoverTemp;
  List<GameInfo> gameInfo = [];

  final responseIds = await http.post(
      Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('search "$searchInfo"; limit 10;'));
  ids = jsonDecode(responseIds.body);

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

  final responseName = await http.post(
      Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('fields name; where id = ($id);'));
  gameInfo.clear();
  gameNamesTemp = jsonDecode(responseName.body);
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
    gameInfo.add(createdGame);
  }

  return gameInfo;
}
