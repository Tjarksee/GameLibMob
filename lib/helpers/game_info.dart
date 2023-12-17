import 'package:flutter/material.dart';

enum Status { wantToPlayThisFucker, stillPlaying, completed }

class GameInfo {
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

  GameInfo(
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
}
