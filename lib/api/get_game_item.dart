import 'dart:collection';
import 'dart:convert';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:http/http.dart' as http;

class _GamesInfo {
  List<String> gameIds = [];
  List<String> coverIds = [];
  List<String> releaseDates = [];
  List<List<String>> genreIds = [];
  List<String> names = [];
  List<List<String>> platformIds = [];
  List<double> ratings = [];
  List<int> ratingCounts = [];
  List<String> summaries = [];
  List<String> storylines = [];
  List<String> urls = [];
}

Future<List<GameItem>> getGameItem(IGDBToken apiToken, String search) async {
  String token = apiToken.accessToken;
  String searchInfo = search;
  List<dynamic> ids;
  List<dynamic> dynamicInfos;

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
    return Future.error(
        'Exception: No Games Found', StackTrace.fromString("This is a Test"));
  }
  String id = '';
  for (var i = 0; i < ids.length; i++) {
    var map = HashMap.from(ids[i]);
    map.forEach((key, value) {
      id = '$id$value,';
    });
  }
  id = id.substring(0, id.length - 1);

  final response = await http.post(Uri.parse('https://api.igdb.com/v4/games'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body:
          ('fields cover,first_release_date,genres,name,platforms,rating,rating_count,summary,storyline,url; where id = ($id);'));
  dynamicInfos = jsonDecode(response.body);

  var gamesInfo = _GamesInfo();
  for (final game in dynamicInfos) {
    final gameId = game["id"].toString();
    gamesInfo.gameIds.add(gameId);
    if (game["cover"] != null) {
      final coverId = game["cover"].toString();
      gamesInfo.coverIds.add(coverId);
    } else {
      gamesInfo.coverIds.add("");
    }

    String releaseDate = "";
    if (game["first_release_date"] != null) {
      int timestamp = game["first_release_date"];
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      releaseDate = date.toString();
      gamesInfo.releaseDates.add(releaseDate);
    } else {
      gamesInfo.releaseDates.add("");
    }
    if (game["genres"] != null) {
      List<String> genreIds = [];
      for (final genre in game["genres"]) {
        final genreId = genre.toString();
        genreIds.add(genreId);
        // final genreResponse = await http.post(
        //     Uri.parse('https://api.igdb.com/v4/genres'),
        //     headers: {
        //       "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        //       "Authorization": "Bearer $token"
        //     },
        //     body: ('fields name; where id = ($genreId);'));
        // final decodedCover = jsonDecode(genreResponse.body);
        // String genreName = decodedCover[0]['name'];
        // genres.add(genreName);
      }
      gamesInfo.genreIds.add(genreIds);
    } else {
      gamesInfo.genreIds.add(List<String>.empty());
    }
    final name = game["name"];
    gamesInfo.names.add(name);
    if (game["platforms"] != null) {
      List<String> platformIds = [];
      for (final platform in game["platforms"]) {
        final platformId = platform.toString();
        platformIds.add(platformId);
        // final platformResponse = await http.post(
        //     Uri.parse('https://api.igdb.com/v4/platforms'),
        //     headers: {
        //       "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        //       "Authorization": "Bearer $token"
        //     },
        //     body: ('fields name; where id = ($platformId);'));
        // final decodedCover = jsonDecode(platformResponse.body);
        // String name = decodedCover[0]['name'];
        // platforms.add(name);
      }
      gamesInfo.platformIds.add(platformIds);
    } else {
      gamesInfo.platformIds.add(List<String>.empty());
    }

    if (game["rating"] != null) {
      gamesInfo.ratings.add(game["rating"]);
    } else {
      gamesInfo.ratings.add(-1.0);
    }

    if (game["rating_count"] != null) {
      gamesInfo.ratingCounts.add(game["rating_count"]);
    } else {
      gamesInfo.ratingCounts.add(-1);
    }

    if (game["summary"] != null) {
      gamesInfo.summaries.add(game["summary"]);
    } else {
      gamesInfo.summaries.add("");
    }

    var storyline = "";
    if (game["storyline"] != null) {
      storyline = game["storyline"];
    }
    gamesInfo.storylines.add(storyline);

    final url = game["url"];
    gamesInfo.urls.add(url);
  }

  List<GameItem> gameItems = [];
  for (int i = 0; i < gamesInfo.gameIds.length; i++) {
    final GameItem gameInfo = GameItem(
      gameID: gamesInfo.gameIds[i],
      coverId: gamesInfo.coverIds[i],
      genreIds: gamesInfo.genreIds[i],
      name: gamesInfo.names[i],
      platformIds: gamesInfo.platformIds[i],
      rating: gamesInfo.ratings[i],
      ratingCount: gamesInfo.ratingCounts[i],
      summary: gamesInfo.summaries[i],
      storyline: gamesInfo.storylines[i],
      url: gamesInfo.urls[i],
    );
    gameItems.add(gameInfo);
  }
  return gameItems;
}
