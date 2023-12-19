import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelib_mob/list/game_item.dart';

class FirebaseTraffic {
  static Future<List<GameItem>> pullFirebase() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    List<GameItem> favGameList = [];

    await firestoreInstance
        .collection('test')
        .doc(firebaseUser!.uid)
        .collection('gamelist')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        // Erstelle eine neue Instanz von GameItem
        GameItem favGame = GameItem(
          cover: result.data()["cover"].toString(),
          gameID: result.data()["gameId"].toString(),
          coverId: result.data()["coverId"].toString(),
          name: result.data()["name"].toString(),
          ourScore: result.data()["ourScore"],
          rating: result.data()["rating"],
          ratingCount: result.data()["ratingCount"],
          releaseDate: result.data()["releaseDate"],
          //status: result.data()["status"],
          storyline: result.data()["storyline"].toString(),
          summary: result.data()["summary"].toString(),
          url: result.data()["url"].toString(),
        );
        // Füge die Instanz zur Liste hinzu
        favGameList.add(favGame);
      }
    });
    return favGameList;
  }

  static void pushGameToFirebase(GameItem gameToPush) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    var docReference = firestoreInstance
        .collection('test')
        .doc(firebaseUser!.uid)
        .collection('gamelist')
        .doc(gameToPush.gameID);

    // Setze die Daten des Spiels im Dokument
    await docReference.set({
      "gameId": gameToPush.gameID,
      "cover": gameToPush.cover,
      "coverId": gameToPush.coverId,
      "name": gameToPush.name,
      "ourScore": gameToPush.ourScore,
      "rating": gameToPush.rating,
      "ratingCount": gameToPush.ratingCount,
      "releaseDate": gameToPush.releaseDate,
      //"status": gameToPush.status.toString(),
      "storyline": gameToPush.storyline,
      "summary": gameToPush.summary,
      "url": gameToPush.url,
    });
  }

  static void deleteGameFromFirebase(GameItem gameToDelete) async {
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      final firestoreInstance = FirebaseFirestore.instance;

      var docReference = firestoreInstance
          .collection('test')
          .doc(firebaseUser!.uid)
          .collection('gamelist')
          .doc(gameToDelete.gameID);

      // Lösche das Dokument
      await docReference.delete();
    } catch (e) {}
  }

  static Future<String?> pushUserNameToFirebase(String name) async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var docRef = firestoreInstance.collection('test');
      docRef.doc(FirebaseAuth.instance.currentUser!.uid).set({'name': name});
      String userId = docRef.id;

      return userId;
    } catch (e) {
      return null;
    }
  }
}
