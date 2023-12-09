import 'package:flutter/material.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

class GameInfo {
  String gameID;
  Image cover;
  List<String> genresIds;
  String name;
  int ourScore;
  List<String> platformsIds;
  double rating;
  int ratingCount;
  String releaseDateId;
  Status status;
  String storyline;
  String summary;
  String url;

  GameInfo(
      {required this.gameID,
      required this.cover,
      this.genresIds = const [],
      required this.name,
      this.ourScore = -1,
      this.platformsIds = const [],
      this.rating = -1,
      this.ratingCount = -1,
      this.releaseDateId = "",
      this.status = Status.wantToPlayThisFucker,
      this.summary = "",
      this.storyline = "",
      this.url = ""});
}
