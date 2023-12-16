import 'package:gamelib_mob/helpers/game_info.dart';
import 'package:gamelib_mob/list/list_class.dart';

class MainList {
  List<GameItem> favouriteGameList = [];

  bool contains(favGameItem) {
    GameItem fav = favGameItem;
    final foundGames = favouriteGameList.where(
        (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
    if (foundGames.isNotEmpty) {
      return true;
    }
    return false;
  }

  void removeFavourite(favGameItem) {
    GameItem fav = favGameItem;
    favouriteGameList.removeWhere(
        (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
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
      if (game.gameItemInfo.status == chosenStatus) {
        counter++;
      }
    }
    return counter;
  }
}
