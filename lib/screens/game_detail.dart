import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/api_services.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';
import 'package:provider/provider.dart';

class GameDetailScreen extends StatefulWidget {
  final GameItem item;
  MainList favouriteGameList;
  GameDetailScreen(this.favouriteGameList, this.item, {super.key});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Center(child: Text(widget.item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))));

    Widget divider = const Divider(
      height: 20,
      thickness: 2,
      indent: 15,
      endIndent: 15,
      color: Colors.black,
    );

    Widget ownScore = Container(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        widget.item.buildCover(context),
        Column(children: [
          widget.item.buildSummary(context),
          widget.item.buildState(context),
          widget.item.buildOwnScore(context),
          HeartButton(widget.favouriteGameList, widget.item),
        ])
      ]),
    );

    Widget igdbStats = Container(
      padding: const EdgeInsets.all(10),
      child: Row(children:[
        widget.item.buildRating(context),
        widget.item.buildSpecifics(context),
      ])
    );

    Widget details = Container(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        //TODO
        Text(widget.item.storyline),
        widget.item.buildUrl(context),
      ])
    );

    final token = Provider.of<IGDBToken>(context, listen: false);
    Future<Image>? coverFuture;
    Future<List<String>>? genresFuture;
    Future<List<String>>? platformsFuture;
    if (widget.item.cover == null) {
      coverFuture = getCover(token.accessToken, widget.item.coverId);
    } else {
      coverFuture = Future.value(widget.item.cover);
    }

    if (widget.item.genres.isEmpty) {
      genresFuture = getGenres(token.accessToken, widget.item.genreIds);
    } else {
      genresFuture = Future.value(widget.item.genres);
    }

    if (widget.item.platforms.isEmpty) {
      platformsFuture =
          getPlatforms(token.accessToken, widget.item.platformIds);
    } else {
      platformsFuture = Future.value(widget.item.platforms);
    }

    return FutureBuilder(
        future: Future.wait([coverFuture, genresFuture, platformsFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?[0] != null) {
              widget.item.cover = snapshot.data![0];
            }
            if (snapshot.data?[1] != null) {
              widget.item.genres = snapshot.data![1];
            }
            if (snapshot.data?[2] != null) {
              widget.item.genres = snapshot.data![2];
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Scaffold(
            appBar: AppBar(title: const Text('Game Details')),
            body: Column(children: [
              titleSection,
              divider,
              ownScore,
              divider,
              igdbStats,
              widget.item.buildReleaseDate(context),
              divider,
              details,
            ]),
          );
        });
  }
}
