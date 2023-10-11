import 'package:flutter/material.dart';

class GameInfo {
  String gameID;
  String name;
  Image cover;
  String desrciption;
  String platform;

  GameInfo(
      {required this.gameID,
        required this.name,
        required this.cover,
        this.desrciption = "",
        this.platform = "Unknown"});
}

final testGame1 = GameInfo(
    gameID: '42',
    name: "testGame",
    cover: Image.asset('assets/images/test.jpg'),
    desrciption: "desciption of test game",
    platform: "Pc");

final testGame2 = GameInfo(
    gameID: '42',
    name: "testGame2",
    cover: Image.asset('assets/images/test.jpg'),
    desrciption: "desciption of test game2",
    platform: "Pc2");