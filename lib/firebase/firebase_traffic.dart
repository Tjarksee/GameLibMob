import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';

class FirebaseTraffic {
  static Future<List<GameItem>> pullFirebase() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    List<GameItem> favGameList = [];

    await firestoreInstance
        .collection('User')
        .doc(firebaseUser!.uid)
        .collection('Gamelist')
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        // Erstelle eine neue Instanz von GameItem
        GameItem favGame = GameItem(
          gameID: result.data()["gameID"].toString(),
          name: result.data()["name"].toString(),
          cover: result.data()["cover"].toString(),
          coverId: result.data()["coverId"].toString(),
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
        .collection('User')
        .doc(firebaseUser!.uid)
        .collection('Gamelist')
        .doc(gameToPush.gameID);

    // Setze die Daten des Spiels ins Dokument
    await docReference.set({
      "gameID": gameToPush.gameID,
      "name": gameToPush.name,
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
          .collection('User')
          .doc(firebaseUser!.uid)
          .collection('Gamelist')
          .doc(gameToDelete.gameID);

      await docReference.delete();
    } catch (e) {
      dynamic errorMessage;
      showDialog(
        context: errorMessage,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konnte spiel nicht löschen"),
            content: const Text(
                "Es ist ein Fehler beim Löschen des Spiels aufgetreten."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  static Future<String?> pushUserNameToFirebase(String name) async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var docRef = firestoreInstance.collection('User');
      docRef.doc(FirebaseAuth.instance.currentUser!.uid).set({'name': name});
      String userId = docRef.id;

      return userId;
    } catch (e) {
      dynamic errorMessage;
      showDialog(
        context: errorMessage,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Registrierung fehlgeschlagen!"),
            content: const Text(
                "Es ist ein Fehler bei der Registrierung aufgetreten."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      // Lösche den erstellten Auth-Nutzer
      FirebaseAuth.instance.currentUser?.delete();
      return null;
    }
  }

  static Future<String> getNameFromFirebase() async {
    String username = "";
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    await firestoreInstance
        .collection('gameLib')
        .doc(firebaseUser!.uid)
        .get()
        .then((querySnapshot) {
      username = querySnapshot.data()?['name'];
    });
    return username;
  }
}
