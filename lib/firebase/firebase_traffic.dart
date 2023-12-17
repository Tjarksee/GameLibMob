import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelib_mob/list/game_item.dart';

import 'package:flutter/material.dart';

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
      querySnapshot.docs.forEach((result) {
        // Erstelle eine neue Instanz von GameItem
        GameItem favGame = GameItem(
          gameID: 'test',
          name: result.data()["name"].toString(),
          // Du solltest entscheiden, wie du das Bild darstellen möchtest.
          // Hier wird angenommen, dass es als String (URL) in Firebase gespeichert wurde.
          cover: Image.network(result.data()["cover"].toString()),
          summary: result.data()["description"].toString(),
          platforms: result.data()["platform"],
        );

        // Füge die Instanz zur Liste hinzu
        favGameList.add(favGame);
      });
      print("Spiele erfolgreich aus DB geladen");
    });

    return favGameList;
  }

  static void pushGameListToFirebase(List<GameItem> favGameList) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    for (var favGame in favGameList) {
      // Verwende eine eindeutige ID für jedes Spiel (z.B., die gameID)
      var docReference = firestoreInstance
          .collection('test')
          .doc(firebaseUser!.uid)
          .collection('gamelist')
          .doc(favGame.gameID);

      // Setze die Daten des Spiels im Dokument
      await docReference.set({
        "gameID": favGame.gameID,
        "name": favGame.name,
        // Du solltest entscheiden, wie du das Bild in Firebase speichern möchtest.
        // Hier speichere ich den Bild-Asset-Pfad als String.
        "cover": favGame.cover.toString(),
        "description": favGame.summary,
        "platform": favGame.gameItemInfo.platform,
      });
    }

    print("Spiele erfolgreich zur Datenbank hinzugefügt");
  }

  static void pushUserNameToFirebase(String name) async {
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection('test').add({
      'userName': name,
    }).then((value) {
      print(value.id);
    });
  }

  static void removeFromFirebase() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    var collection = firestoreInstance
        .collection("test")
        .doc(firebaseUser!.uid)
        .collection("gameList");
    var snapshots = await collection.get();
    //Der geht aktuell nicht in die for schleife rein Frage Warum?
    for (var doc in snapshots.docs) {
      print("test");
      await doc.reference.delete();
      print("Game gelöscht");
    }
  }
}
