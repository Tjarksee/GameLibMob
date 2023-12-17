import 'package:gamelib_mob/firebase/firebase_traffic.dart';
import 'game_item.dart';

class MainList {
  List<GameItem> favouriteGameList = [];

  bool contains(favGameItem) {
    GameItem fav = favGameItem;
    final foundGames =
        favouriteGameList.where((element) => element.gameID == fav.gameID);
    if (foundGames.isNotEmpty) {
      return true;
    }
    return false;
  }

  void removeFavourite(favGameItem) {
    GameItem fav = favGameItem;
    favouriteGameList.removeWhere((element) => element.gameID == fav.gameID);
    FirebaseTraffic.removeFromFirebase();
  }

  void addFav(GameItem favGameItem) {
    favouriteGameList.add(favGameItem);
    // Push to DB
    FirebaseTraffic.pushGameListToFirebase(favouriteGameList);
  }

  void addFavourite(favGameItem) {
    GameItem selectedGame = favGameItem;

    favouriteGameList.add(selectedGame);
  }

  List<GameItem> getFavouriteList() {
    return favouriteGameList;
  }

  int getStatusAmount(Status chosenStatus) {
    int counter = 0;
    for (final game in favouriteGameList) {
      if (game.status == chosenStatus) {
        counter++;
      }
    }
    return counter;
  }
}
