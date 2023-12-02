
void pullFirebase(){

}

void pushFirebase(){

}

firestoreInstance.collection("User").add({
"userName": "john",
"email": "example@example.com",
"password": "test"
}).then((value) {
    print(value.id);
    firestoreInstance
    .collection("User")
    .doc(value.id)
    .collection("gameList")
  for(int i = 0,i <  ,i++){
    .add({gameList[i]});
}
});