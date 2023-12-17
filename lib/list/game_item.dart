import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_item.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

/// A GameItem that contains data to all the info about a game.
class GameItem implements ListItem {
  String gameID;
  Image cover;
  List<String> genres;
  String name;
  int ourScore;
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
      required this.cover,
      this.genres = const [],
      required this.name,
      this.ourScore = -1,
      this.platforms = const [],
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
  Widget buildLeading(BuildContext context) {
    return cover;
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }
}
