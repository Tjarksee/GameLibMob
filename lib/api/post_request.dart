import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gamelib_mob/helpers/game_class.dart';

Future<List<GameInfo>> getGameInfo(apiToken, search) async {
  String token = apiToken;
  String searchInfo = search;
  List<dynamic> ids;
  List<dynamic> dynamicInfos;
  List<GameInfo> gameInfo = [];

  final responseIds = await http.post(Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        // TODO
        // SICHERHEITSLÜCKE git secrets benutzen
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('search "$searchInfo"; limit 10;'));
  ids = jsonDecode(responseIds.body);

  if (ids.isEmpty) {
    //TODO
    print("HAHA KEIN ABSTURZ MEHR. ICH REPARIERE DINGE");
  }
  String id = '';
  for (var i = 0; i < ids.length; i++) {
    var map = HashMap.from(ids[i]);
    map.forEach((key, value) {
      id = '$id$value,';
    });
  }
  id = id.substring(0, id.length - 1);

  final response = await http.post(
      Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('fields age_ratings,cover,first_release_date,genres,name,platforms,rating,rating_count,summary,url; where id = ($id);'));
      dynamicInfos = jsonDecode(response.body);


  gameInfo.clear();
  for(final game in dynamicInfos){
    final GameInfo gameInfo = GameInfo(gameID: game["id"], ageRating: game["age_ratings"], coverId: game["cover"], releaseDateId: game["first_release_date"],genresId: game["genres"] , name: game["name"]);
    gameInfo.add(GameInfo(gameID: game["id"], name: game[""]))
    final id = game["id"];


  }

  return gameInfo;
}


// Future<List<ShortInfo>> getShortInfo(apiToken, gameInfos) async {
//   // für jedes gameInfo, die cover IDs raussuchen und in eine Liste speichern
//   final responseCover = await http.post(
//       Uri.parse('https://api.igdb.com/v4/covers'),
//       headers: {
//         "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
//         "Authorization": "Bearer $token"
//       },
//       body: ('fields url; where id = ($cover_id);'));
//   gameCoverTemp = jsonDecode(responseCover.body);
//   // für jedes gameInfo, den namen raussuchen und in die selbe liste an shortinfos speichern?
//   // liste an shortinfos rausgeben
// }