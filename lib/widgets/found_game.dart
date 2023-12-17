import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FoundGame extends StatefulWidget {
  final GameItem item;
  final MainList favouriteGameList;
  const FoundGame(this.favouriteGameList, this.item, {super.key});

  @override
  State<FoundGame> createState() => _FoundGameState();
}

class _FoundGameState extends State<FoundGame> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<IGDBToken>(context, listen: false);
    String coverId = widget.item.coverId;
    Future<Image>? coverFuture;
    if (widget.item.cover == null) {
      coverFuture = getCover(token.accessToken, coverId);
    } else {
      coverFuture = null;
    }

    return FutureBuilder<Image>(
            future: coverFuture,
            builder: (context, AsyncSnapshot<Image> snapshot) {
              if (snapshot.hasData) {
                widget.item.cover = snapshot.data;
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
                return ListTile(
                    leading: widget.item.buildLeading(context),
                    title: widget.item.buildTitle(context),
                    subtitle: widget.item.buildSubtitle(context),
                    trailing:
                        HeartButton(widget.favouriteGameList, widget.item),
                    onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const GameDetailScreen();
                        })));
            });
  }
}

Future<Image> getCover(String token, String coverId) async {
  final responseCover = await http.post(
      Uri.parse('https://api.igdb.com/v4/covers'),
      headers: {
        "Client-ID": "jatk8moav95uswe6bq3zmcy3fokdnw",
        "Authorization": "Bearer $token"
      },
      body: ('fields url; where id = $coverId;'));
  final decodedCover = jsonDecode(responseCover.body);
  if (decodedCover[0]["url"] == null) {
    return Image.asset("assets/not_found.jpg");
  }
  final url = 'https:${decodedCover[0]["url"]}';
  return Image.network(url);
}
