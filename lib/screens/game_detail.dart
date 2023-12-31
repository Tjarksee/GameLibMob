import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/api_services.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/game_item.dart';

import 'package:gamelib_mob/widgets/heart_button.dart';
import 'package:provider/provider.dart';

class GameDetailScreen extends StatefulWidget {
  final GameItem item;
  const GameDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  Color completed = Colors.grey;
  Color planned = Colors.grey;
  Color inProgress = Colors.grey;
  @override
  Widget build(BuildContext context) {
    double width;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      width = MediaQuery.of(context).size.width;
    } else {
      width = MediaQuery.of(context).size.width;
    }

    if (widget.item.status == Status.completed) {
      completed = Colors.red;
    } else if (widget.item.status == Status.stillPlaying) {
      inProgress = Colors.red;
    } else {
      planned = Colors.red;
    }
    Widget titleSection = Container(
        padding: const EdgeInsets.all(32),
        child: Center(
            child: Text(widget.item.name,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 243, 243), fontSize: 25))));

    Widget divider = const Divider(
      height: 20,
      thickness: 2,
      indent: 15,
      endIndent: 15,
      color: Colors.black,
    );

    Widget stateButton = Row(
      children: <Widget>[
        SizedBox(
          width: (width / 3),
          child: ElevatedButton(
            onPressed: () {
              planned = Colors.red;
              setState(() {
                completed = Colors.grey;
                inProgress = Colors.grey;
                widget.item.changeStatus(Status.wantToPlayThisFucker);
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: planned),
            child: const Text('want to play'),
          ),
        ),
        SizedBox(
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                inProgress = Colors.red;
                setState(() {
                  planned = Colors.grey;
                  completed = Colors.grey;
                  widget.item.changeStatus(Status.stillPlaying);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: inProgress),
              child: const Text('In Progress'),
            )),
        SizedBox(
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                completed = Colors.red;
                setState(() {
                  planned = Colors.grey;
                  inProgress = Colors.grey;
                  widget.item.changeStatus(Status.completed);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: completed),
              child: const Text('Completed'),
            ))
      ],
    );

    Widget slider = SizedBox(
        width: (width / 1.5),
        child: Slider(
          value: widget.item.ourScore.toDouble(),
          max: 100,
          divisions: 5,
          label: widget.item.ourScore.toString(),
          onChanged: (double value) {
            setState(() {
              widget.item.changeScore(value.toInt());
            });
          },
        ));

    Widget ownScore = Column(
      children: [
        Row(children: [
          SizedBox(
            width: width / 3,
            child: widget.item.buildCover(context),
          ),
          SizedBox(
              width: (width / 1.5),
              child: Column(
                children: [
                  widget.item.buildSummary(context, width),
                  slider,
                  HeartButton(
                    widget.item,
                  ),
                ],
              ))
        ]),
        stateButton,
      ],
    );

    Widget igdbStats = Row(children: [
      widget.item.buildRating(context, width),
      widget.item.buildSpecifics(context),
    ]);

    Widget details = Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const Text(
            "Story of the Game: ",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 243, 243), fontSize: 20),
          ),
          SizedBox(
            width: width, // Set the desired width of the box
            child: Wrap(
              children: [
                ExpandableText(
                  widget.item.storyline,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 3,
                  linkColor: const Color.fromARGB(255, 102, 153, 234),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 243, 243), fontSize: 17),
                ) // Allow the text to wrap
              ],
            ),
          ),
          divider,
          widget.item.buildUrl(context),
        ]));

    final token = Provider.of<IGDBToken?>(context, listen: true);
    Future<String>? coverFuture;
    Future<List<String>>? genresFuture;
    Future<List<String>>? platformsFuture;
    if (token != null) {
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
              backgroundColor: const Color.fromARGB(84, 87, 85, 99),
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
              ),
            );
          });
    }
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
