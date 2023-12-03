import 'package:flutter/material.dart';

Widget profilePage(BuildContext context, String name, List<String> stats) {
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
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(248, 24, 217, 101),
                    Color.fromARGB(249, 108, 106, 108),
                    Color.fromARGB(249, 50, 48, 50)
                  ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                ),
                Container(
                  width: width / 2,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(248, 24, 217, 101),
                    Color.fromARGB(249, 108, 106, 108),
                    Color.fromARGB(249, 50, 48, 50)
                  ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                  child: Text(name),
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
