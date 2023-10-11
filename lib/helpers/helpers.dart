import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/screens/signIn.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width,
            height: mainContainerHight,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
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
          Container(
              width: width,
              height: mainContainerHight,
              child: Container(
                alignment: Alignment.center,
                height: 1,
                width: width,
                child: firebaseUIButton(context, "logout", () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  });
                }),
              )),
        ],
      ));
}