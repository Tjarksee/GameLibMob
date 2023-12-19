import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_item.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

/// A GameItem that contains data to all the info about a game.
class GameItem implements ListItem {
  String gameID;
  String? cover;
  String coverId;
  List<String> genreIds;
  List<String> genres;
  String name;
  int ourScore;
  List<String> platformIds;
  List<String> platforms;
  double rating;
  int ratingCount;
  String releaseDate;
  Status status;
  String storyline;
  String summary;
  String url;

  GameItem(
      {required this.gameID,
      this.cover,
      this.coverId = "",
      this.genres = const [],
      this.genreIds = const [],
      required this.name,
      this.ourScore = 0,
      this.platforms = const [],
      this.platformIds = const [],
      this.rating = -1,
      this.ratingCount = -1,
      this.releaseDate = "",
      this.status = Status.wantToPlayThisFucker,
      this.summary = "",
      this.storyline = "",
      this.url = ""});

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 243, 243), fontSize: 20),
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildCover(BuildContext context) {
    if (cover == null) {
      return const CircularProgressIndicator();
      //return Image.asset("asset/not_found.jpg");
    } else {
      if (cover![0] == 'h') {
        return Image.network(cover!);
      } else {
        return Image.asset("assets/not_found.jpg");
      }
    }
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget buildSummary(BuildContext context, double width) {
    return SizedBox(
      width: width / 1.7,
      child: Wrap(
        children: [
          ExpandableText(
            summary,
            expandText: 'show more',
            collapseText: 'show less',
            maxLines: 3,
            linkColor: Colors.amber,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 243, 243), fontSize: 17),
          )
        ],
      ),
    );
  }

  Widget buildUrl(BuildContext context) {
    return InkWell(
        child: Text(
          "Url to Homepage:\n $url",
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 243, 243), fontSize: 17),
        ),
        onTap: () async => {await launchUrl(Uri.parse(url))});
  }

  Widget buildRating(BuildContext context, double width) {
    // TODO
    // Zeigt fett den Score an mit dem ratingcount drunter
    // muss noch schöner werden
    return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Igdb raiting: ${rating.toStringAsFixed(2)}%",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 243, 243), fontSize: 20),
            ),
            Text(
              "Number of raitings: ${ratingCount.toString()}",
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 239, 239), fontSize: 15),
            ),
          ],
        ));
  }

  Widget buildSpecifics(BuildContext context) {
    return const Column(
      children: [
        // for each platform -> Text(platforms),
        // for each genre -> Text(genres),
      ],
    );
  }

  Widget buildReleaseDate(BuildContext context) {
    return Text(releaseDate);
  }
}
