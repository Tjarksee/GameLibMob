import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/helpers/game_class.dart';
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
          GameInfo(
            gameID: result.data()["gameID"].toString(),
            name: result.data()["name"].toString(),
            cover: Image.network(result.data()["cover"].toString()),
            desrciption: result.data()["description"].toString(),
            platform: result.data()["platform"].toString(),
          ),
        );

        // Füge die Instanz zur Liste hinzu
        favGameList.add(favGame);
      });
      print("Spiele erfolgreich aus DB geladen");
    });

    return favGameList;
  }


  /*static void pushGameListToFirebase(List<GameItem> favGameList) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    for (var favGame in favGameList) {
      var docReference = firestoreInstance
          .collection('test')
          .doc(firebaseUser!.uid)
          .collection('gamelist')
          .doc(favGame.gameItemInfo.gameID);

      // Setze die Daten des Spiels im Dokument
      await docReference.set({
        "gameID": favGame.gameItemInfo.gameID,
        "name": favGame.gameItemInfo.name,
        "cover": favGame.gameItemInfo.cover.toString(),
        "description": favGame.gameItemInfo.desrciption,
        "platform": favGame.gameItemInfo.platform,
      });
    }

    print("Spiele erfolgreich zur Datenbank hinzugefügt");
  }

  static void pushUserNameToFirebase(String name) async{
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection('test').add({
      'userName': name,
    }).then((value) {
      print(value.id);
    });
  }*/

  static void removeFromFirebase() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    var collection = firestoreInstance.collection("test").doc(
        firebaseUser!.uid).collection("gameList");
    var snapshots = await collection.get();
    //Der geht aktuell nicht in die for schleife rein Frage Warum?
    for (var doc in snapshots.docs) {
      print("test");
      await doc.reference.delete();
      print("Game gelöscht");
    }
  }

  static Future<String?> pushUserNameToFirebase(String name) async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var docRef = await firestoreInstance.collection('test').add({
        'userName': name,
      });

      String userId = docRef.id;
      print(userId);

      return userId;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static void pushGameListToFirebase(List<GameItem> favGameList, String userId) async {
    final firestoreInstance = FirebaseFirestore.instance;

    print("Test");
    print(userId);
    for (var favGame in favGameList) {
      var docReference = firestoreInstance
          .collection('test')
          .doc(userId)
          .collection('gamelist')
          .doc(favGame.gameItemInfo.gameID);

      // Setze die Daten des Spiels im Dokument
      await docReference.set({
        "gameID": favGame.gameItemInfo.gameID,
        "name": favGame.gameItemInfo.name,
        "cover": favGame.gameItemInfo.cover.toString(),
        "description": favGame.gameItemInfo.desrciption,
        "platform": favGame.gameItemInfo.platform,
      });
    }

    print("Spiele erfolgreich zur Datenbank hinzugefügt");
  }
}


