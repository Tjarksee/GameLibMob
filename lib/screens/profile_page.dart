import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelib_mob/helpers/game_info.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/helpers/helpers.dart';
import 'package:gamelib_mob/screens/sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final MainList favouriteGameList;
  const ProfileScreen({super.key, required this.favouriteGameList});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MainList favouriteGameList = widget.favouriteGameList;
  @override
  Widget build(BuildContext context) {
    double width;
    double height;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height - 193;
    } else {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height - 133;
    }
    double mainContainerHight = height * 1 / 3;

    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(249, 50, 48, 50),
          Color.fromARGB(249, 108, 106, 108),
          Color.fromARGB(249, 50, 48, 50)
        ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: Column(children: [
          Container(
            width: width,
            height: mainContainerHight,
            child: Row(
              children: [
                Container(
                  width: width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 5,
                  )),
                  child: Image(
                    image: AssetImage('assets/profile_pictures/unicorn.png'),
                    width: width / 4,
                    height: mainContainerHight / 1.5,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile Name:',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    // TODO get the profile name here
                    const Text(
                      "Profile name from db",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "E-Mail:",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      getEmail(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: mainContainerHight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: mainContainerHight,
                  width: width / 3,
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: const Text(
                          'Currently playing',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: Text(
                          favouriteGameList
                              .getStatusAmount(Status.stillPlaying)
                              .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: mainContainerHight,
                  width: width / 3,
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: const Text(
                          'Games Finished',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: Text(
                          favouriteGameList
                              .getStatusAmount(Status.completed)
                              .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: mainContainerHight,
                  width: width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: const Text(
                          'Planed to Play',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mainContainerHight / 2,
                        width: width / 3,
                        child: Text(
                          favouriteGameList
                              .getStatusAmount(Status.wantToPlayThisFucker)
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          firebaseUIButton(context, "logout", () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          }),
        ]));
  }
}

Future<void> changePopup(BuildContext context, String changeInformation) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change your $changeInformation'),
          content: TextField(
            autofocus: true,
            decoration:
                InputDecoration(hintText: 'Your new $changeInformation'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'))
          ],
        );
      });
}
