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
        .collection('User')
        .doc(firebaseUser!.uid)
        .collection('Gamelist')
        .doc(gameToPush.gameID);

    // Setze die Daten des Spiels ins Dokument
    await docReference.set({
      "gameID": gameToPush.gameID,
      "name": gameToPush.name,
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
          .collection('User')
          .doc(firebaseUser!.uid)
          .collection('Gamelist')
          .doc(gameToDelete.gameID);

      // Lösche das Dokument
      await docReference.delete();
    } catch (e) {
      FirebaseAuth.instance.signOut();
      dynamic errorMessage;
      showDialog(
        context: errorMessage,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Löschvorgang fehlgeschlagen, sie werden jetzt ausgeloggt!"),
            content: const Text("Es ist ein Fehler aufgetreten. Änderung erforderlich."),
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
            content: const Text("Es ist ein Fehler bei der Registrierung aufgetreten."),
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
}
