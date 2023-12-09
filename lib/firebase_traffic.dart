import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final firestoreInstance = FirebaseFirestore.instance;

void pullFirebase(){

}

void pushFirebase() {
  firestoreInstance.collection('test').add({
    'userName': "test",
    'stadt' : "kiel",
  }).then((value){
    print(value.id);
  });
}

