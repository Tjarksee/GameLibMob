import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: Column(
          children: [
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
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Profile Name:',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // TODO get the profile name here
                      Text(
                        "jhhj",
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Profile Name:',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // TODO get the profile name here
                      Text(
                        "jhhj",
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Profile Name:',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      // TODO get the profile name here
                      Text(
                        "jhhj",
                      )
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
                          child: Text(
                            'Games Played',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: mainContainerHight / 2,
                          width: width / 3,
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: mainContainerHight,
                    width: width / 3,
                    decoration: BoxDecoration(
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
                          child: Text(
                            'Games Finished',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: mainContainerHight / 2,
                          width: width / 3,
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 15),
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
                          child: Text(
                            'Planed to Play',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: mainContainerHight / 2,
                          width: width / 3,
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
