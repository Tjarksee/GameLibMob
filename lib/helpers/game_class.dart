import 'package:flutter/material.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

class GameInfo {
  String gameID;
  String coverId;
  List<String> genresIds;
  String name;
  int ourScore;
  List<String> platformsIds;
  double rating;
  int ratingCount;
  String releaseDateId;
  Status status;
  String summary;
  String url;

  GameInfo(
      {required this.gameID,
      this.coverId = "",
      this.genresIds = const [],
      required this.name,
      this.ourScore = -1,
      this.platformsIds = const [],
      this.rating = -1,
      this.ratingCount = -1,
      this.releaseDateId = "",
      this.status = Status.wantToPlayThisFucker,
      this.summary = "",
      this.url = ""});
}
