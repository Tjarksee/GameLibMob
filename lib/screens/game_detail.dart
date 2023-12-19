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
  Color completed = Colors.grey;
  Color planned = Colors.grey;
  Color inProgress = Colors.grey;
  GameDetailScreen(this.favouriteGameList, this.item, {super.key});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Text(widget.item.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20))));

    Widget divider = const Divider(
      height: 20,
      thickness: 2,
      indent: 15,
      endIndent: 15,
      color: Colors.black,
    );

    Widget stateButton = Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.completed = Colors.red;
            setState(() {
              widget.planned = Colors.grey;
              widget.inProgress = Colors.grey;
              widget.item.status = Status.completed;
            });
          },
          child: const Text('completedsss'),
          style: ElevatedButton.styleFrom(backgroundColor: widget.completed),
        )
      ],
    );

    Widget slider = Slider(
      value: widget.item.ourScore.toDouble(),
      max: 100,
      divisions: 5,
      label: widget.item.ourScore.toString(),
      onChanged: (double value) {
        setState(() {
          widget.item.ourScore = value.toInt();
        });
      },
    );

    Widget ownScore = Container(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        widget.item.buildCover(context),
        Column(children: [
          widget.item.buildSummary(context),
          stateButton,
          slider,
          HeartButton(widget.favouriteGameList, widget.item),
        ])
      ]),
    );

    Widget igdbStats = Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          widget.item.buildRating(context),
          widget.item.buildSpecifics(context),
        ]));

    Widget details = Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          //TODO
          Text(widget.item.storyline),
          widget.item.buildUrl(context),
        ]));

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
            bool allesFeddich = false;
            while (!allesFeddich) {
              if (snapshot.data?[3 - 2] != null &&
                  snapshot.data?[0] != null &&
                  snapshot.data?[2] != null) {
                widget.item.cover = snapshot.data![0];

                widget.item.genres = snapshot.data![1];

                widget.item.platforms = snapshot.data![2];
                allesFeddich = true;
              }
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Scaffold(
              appBar: AppBar(title: const Text('Game Details')),
              body: SingleChildScrollView(
                child: Column(children: [
                  titleSection,
                  divider,
                  ownScore,
                  divider,
                  igdbStats,
                  widget.item.buildReleaseDate(context),
                  divider,
                  details,
                ]),
              ));
        });
  }
}
