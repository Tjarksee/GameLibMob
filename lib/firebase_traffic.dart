import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


  final firestoreInstance = FirebaseFirestore.instance;

  void pullFirebase() {

  }

  void pushUserNameToFirebase(String name) {
    firestoreInstance.collection('test').add({
      'userName': name,
    }).then((value) {
      print(value.id);
    });
  }

void pushGameListToFirebase() {
  firestoreInstance.collection('test').add({
    'userName': "test",
    'stadt': "kiel",
  }).then((value) {
    print(value.id);
  });
}

