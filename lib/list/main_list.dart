import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/firebase_traffic.dart';

class MainList {
  List<GameItem> favList = [];

  bool contains1(favGameItem) {
    GameItem fav = favGameItem;
    final foundGames = favList.where(
            (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
    if (foundGames.isNotEmpty) {
      return true;
    }
    return false;
  }
//dasdsa
  void removeFav(favGameItem) {
    GameItem fav = favGameItem;
    favList.removeWhere(
            (element) => element.gameItemInfo.gameID == fav.gameItemInfo.gameID);
    //Remove from DB
    removeFromFirebase();
  }

  void addFav(favGameItem) {
    GameItem fav = favGameItem;

    favList.add(fav);
    //Push to DB
    pushGameListToFirebase();
  }

  List<GameItem> getFavList() {
    return favList;
  }
}