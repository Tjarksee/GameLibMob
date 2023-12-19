import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_item.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:gamelib_mob/widgets/button_with_menu_state.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

/// A GameItem that contains data to all the info about a game.
class GameItem implements ListItem {
  String gameID;
  Image? cover;
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
      required this.genreIds,
      required this.name,
      this.ourScore = -1,
      this.platforms = const [],
      required this.platformIds,
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
      style: Theme.of(context).textTheme.headlineSmall,
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
      return cover!;
    }
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget buildSummary(BuildContext context) {
    // TODO
    // Eine kurze Beschreibung des Spiels
    return Container(
      width: 200, // Set the desired width of the box
      child: Wrap(
        children: [
          ExpandableText(
            summary,
            expandText: 'show more',
            collapseText: 'show less',
            maxLines: 3,
            linkColor: Colors.amber,
          ) // Allow the text to wrap
        ],
      ),
    );
  }

  Widget buildUrl(BuildContext context) {
    // TODO
    // Eine URL ins schöne
    return Text("not implementssed");
  }

  Widget buildState(BuildContext context) {
    // TODO
    // ein menuknopf, der die drei Optionen von Status.X anzeigt
    // und diese dann für status auswählt. Startet mit dem jetzigen
    return ButtonWithMenu();
  }

  Widget buildOwnScore(BuildContext context, double currentSliderValue,
      Function setStateCallback) {
    // TODO
    // Ein Schieberegler, der den eigenen Score anzeigt (startet auf dem eigenen)
    return Text('data');
  }

  Widget buildRating(BuildContext context) {
    // TODO
    // Zeigt fett den Score an mit dem ratingcount drunter
    // muss noch schöner werden
    return Column(
      children: [
        Text(
          rating.toString(),
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
        ),
        Text(
          ratingCount.toString(),
          style: const TextStyle(
              color: Color.fromARGB(255, 9, 9, 9), fontSize: 15),
        ),
      ],
    );
  }

  Widget buildSpecifics(BuildContext context) {
    // TODO
    // Zeigt fett den Score an mit dem ratingcount drunter
    // muss noch schöner werden
    return Column(
      children: [
        // for each platform -> Text(platforms),
        // for each genre -> Text(genres),
      ],
    );
  }

  Widget buildReleaseDate(BuildContext context) {
    // TODO
    // Ein Schieberegler, der den eigenen Score anzeigt (startet auf dem eigenen)
    return Text(releaseDate);
  }
}
