import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


  void pullFirebase() async {
    /*var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance.collection('test').doc(firebaseUser!.uid).collection(
        'gamelist').get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        // Game wird hinzugefügt (alle Attribute)
        favList.add(Game(
            result.data()["petName"].toString(),
            result.data()["petType"].toString(),
            result.data()["petAge"].toString(),
        ));
      });
      //print("Games erfolgreich aus DB geladen");
    });*/
  }

  void pushUserNameToFirebase(String name) async{
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection('test').add({
      'userName': name,
    }).then((value) {
      print(value.id);
    });
  }

void pushGameListToFirebase() async{
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance.collection('test').doc(firebaseUser!.uid).collection('gamelist').add({
        "petName": "black",
        "petType": "dog",
        "petAge": 1});
    }


void removeFromFirebase() async{
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  var collection = firestoreInstance.collection("test").doc(
      firebaseUser!.uid).collection("gameList");
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    print("test");
    await doc.reference.delete();
    print("Game gelöscht");
  }
}

