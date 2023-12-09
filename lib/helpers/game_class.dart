import 'package:flutter/material.dart';

enum Status {
  wantToPlayThisFucker,
  stillPlaying,
  completed
}

class GameInfo {
  String gameID;
  double ageRating;
  String coverId;
  String genresId;
  String name;
  int ourScore;
  String platformId;
  double rating;
  String releaseDatesId;
  Status status;
  String summary;
  String url;

  GameInfo(
      {required this.gameID,
      this.ageRating = 0,
      this.coverId = "",
      this.genresId = "",
      required this.name,
      this.ourScore = -1,
      this.platformId = "",
      this.rating = -1,
      this.releaseDatesId = "",
      this.status = Status.wantToPlayThisFucker,
      this.summary = "",
      this.url = ""});
}