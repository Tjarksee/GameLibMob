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
          gameID: result.data()["gameID"].toString(),
          name: result.data()["name"].toString(),
          // Du solltest entscheiden, wie du das Bild darstellen möchtest.
          // Hier wird angenommen, dass es als String (URL) in Firebase gespeichert wurde.
          cover: result.data()["cover"].toString(),
          summary: result.data()["description"].toString(),
          platformIds: ['test', 'das'],
          genreIds: ['test', 'das'],
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
      "gameID": gameToPush.gameID,
      "name": gameToPush.name,
      // Du solltest entscheiden, wie du das Bild in Firebase speichern möchtest.
      // Hier speichere ich den Bild-Asset-Pfad als String.
      "cover": gameToPush.cover,
      "description": gameToPush.summary,
      "platform": gameToPush.platforms,
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
