import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/firebase_traffic.dart';

class MainList {
  String userId;
  List<GameItem> favList = [];

  MainList({required this.userId});

  bool contains1(GameItem favGameItem) {
    final foundGames = favList.where(
          (element) => element.gameItemInfo.gameID == favGameItem.gameItemInfo.gameID,
    );
    return foundGames.isNotEmpty;
  }

  void removeFav(GameItem favGameItem) {
    favList.removeWhere(
          (element) => element.gameItemInfo.gameID == favGameItem.gameItemInfo.gameID,
    );
    // Remove from DB
    FirebaseTraffic.removeFromFirebase();
  }

  void addFav(GameItem favGameItem) {
    favList.add(favGameItem);
    // Push to DB
    FirebaseTraffic.pushGameListToFirebase(favList, userId);
  }

  List<GameItem> getFavList() {
    return favList;
  }
}