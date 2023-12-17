import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:http/http.dart' as http;

Future<List<GameItem>> getGameItem(apiToken, search) async {
  String token = (await apiToken).accessToken;
  String searchInfo = search;
  List<dynamic> ids;
  List<dynamic> dynamicInfos;
  List<GameItem> gameInfos = [];

  final responseIds =
      await http.post(Uri.parse('https://api.igdb.com/v4/games'),
          headers: {
            // TODO
            // SICHERHEITSLÜCKE git secrets benutzen
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

  gameInfos.clear();
  for (final game in dynamicInfos) {
    // convert all ids to strings and rest to appropriate type
    // might need to look for null first and then convert
    final gameId = game["id"].toString();
    Image cover;
    if (game["cover"] != null) {
      final coverId = game["cover"].toString();
      final responseCover = await http.post(
          Uri.parse('https://api.igdb.com/v4/covers'),
          headers: {
            "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
            "Authorization": "Bearer $token"
          },
          body: ('fields url; where id = ($coverId);'));
      final decodedCover = jsonDecode(responseCover.body);
      final url = 'https:${decodedCover[0]["url"]}';
      cover = Image.network(url);
    } else {
      cover = Image.asset('assets/images/test.png');
    }

    String releaseDate = "";
    if (game["first_release_date"] != null) {
      int timestamp = game["first_release_date"];
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      releaseDate = date.toString();
    }
    List<String> genres = [];
    if (game["genres"] != null) {
      for (final genre in game["genres"]) {
        final genreId = genre.toString();
        final genreResponse = await http.post(
            Uri.parse('https://api.igdb.com/v4/genres'),
            headers: {
              "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
              "Authorization": "Bearer $token"
            },
            body: ('fields name; where id = ($genreId);'));
        final decodedCover = jsonDecode(genreResponse.body);
        String name = decodedCover[0]['name'];
        genres.add(name);
      }
    }
    final name = game["name"];
    List<String> platforms = [];
    if (game["platforms"] != null) {
      for (final platform in game["platforms"]) {
        final platformId = platform.toString();
        final platformResponse = await http.post(
            Uri.parse('https://api.igdb.com/v4/platforms'),
            headers: {
              "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
              "Authorization": "Bearer $token"
            },
            body: ('fields name; where id = ($platformId);'));
        final decodedCover = jsonDecode(platformResponse.body);
        String name = decodedCover[0]['name'];
        platforms.add(name);
      }
    }

    var rating = 0.0;
    if (game["rating"] != null) {
      rating = game["rating"];
    }
    var ratingCount = 0;
    if (game["rating_count"] != null) {
      ratingCount = game["rating_count"];
    }
    final summary = game["summary"];
    var storyline = "";
    if (game["storyline"] != null) {
      storyline = game["storyline"];
    }
    final url = game["url"];
    final GameItem gameInfo = GameItem(
        gameID: gameId,
        cover: cover,
        releaseDate: releaseDate,
        genres: genres,
        name: name,
        platforms: platforms,
        rating: rating,
        ratingCount: ratingCount,
        summary: summary,
        storyline: storyline,
        url: url);
    gameInfos.add(gameInfo);
  }

  return gameInfos;
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