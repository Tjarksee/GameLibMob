import 'package:flutter/material.dart';
import 'package:gamelib_mob/firebase/firebase_traffic.dart';
import 'game_item.dart';

class MainList extends ChangeNotifier {
  List<GameItem> gameItems = [];
  String username = '';

  bool contains(favGameItem) {
    GameItem fav = favGameItem;
    final foundGames =
        gameItems.where((element) => element.gameID == fav.gameID);
    if (foundGames.isNotEmpty) {
      return true;
    }
    return false;
  }

  void removeFavourite(favGameItem) {
    GameItem fav = favGameItem;
    gameItems.removeWhere((element) => element.gameID == fav.gameID);
    FirebaseTraffic.deleteGameFromFirebase(fav);
    notifyListeners();
  }

  void addFavourite(favGameItem) {
    GameItem selectedGame = favGameItem;

    gameItems.add(selectedGame);
    FirebaseTraffic.pushGameToFirebase(selectedGame);
    notifyListeners();
  }

  List<GameItem> getFavouriteList() {
    return gameItems;
  }

  int getStatusAmount(Status chosenStatus) {
    int counter = 0;
    for (final game in gameItems) {
      if (game.status == chosenStatus) {
        counter++;
      }
    }
    return counter;
  }

  void changeStatus(int index, Status chosenStatus) {
    gameItems[index].status = chosenStatus;
  }
}
