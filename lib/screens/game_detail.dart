import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
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
    double width;
    double height;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height - 193;
    } else {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height - 133;
    }
    if (widget.item.status == Status.completed) {
      widget.completed = Colors.red;
    } else if (widget.item.status == Status.stillPlaying) {
      widget.inProgress = Colors.red;
    } else {
      widget.planned = Colors.red;
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
              widget.planned = Colors.red;
              setState(() {
                widget.completed = Colors.grey;
                widget.inProgress = Colors.grey;
                widget.item.status = Status.wantToPlayThisFucker;
              });
            },
            child: const Text('want to play'),
            style: ElevatedButton.styleFrom(backgroundColor: widget.planned),
          ),
        ),
        SizedBox(
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                widget.inProgress = Colors.red;
                setState(() {
                  widget.planned = Colors.grey;
                  widget.completed = Colors.grey;
                  widget.item.status = Status.stillPlaying;
                });
              },
              child: const Text('In Progress'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: widget.inProgress),
            )),
        SizedBox(
            width: width / 3,
            child: ElevatedButton(
              onPressed: () {
                widget.completed = Colors.red;
                setState(() {
                  widget.planned = Colors.grey;
                  widget.inProgress = Colors.grey;
                  widget.item.status = Status.completed;
                });
              },
              child: const Text('Completed'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: widget.completed),
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
              widget.item.ourScore = value.toInt();
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
                  HeartButton(widget.favouriteGameList, widget.item),
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
                  linkColor: Color.fromARGB(255, 102, 153, 234),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 243, 243), fontSize: 17),
                ) // Allow the text to wrap
              ],
            ),
          ),
          divider,
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
            backgroundColor: Color.fromARGB(84, 87, 85, 99),
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
}
