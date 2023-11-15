import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/screens/home.dart';
import 'package:gamelib_mob/screens/signup.dart';
import '../helpers/helpers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showError = false;
  String errorMessage = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(249, 50, 48, 50),
              Color.fromARGB(249, 108, 106, 108),
              Color.fromARGB(249, 50, 48, 50)
            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(children: <Widget>[
                  reusableTextField("Enter UserName", Icons.person_outline,
                      false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enterdsa Password", Icons.lock_outline,
                      true, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return errorMessage;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    showError ? errorMessage : '',
                    style: TextStyle(color: Colors.red),
                  ),
                  firebaseUIButton(context, "Login", () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                    } on FirebaseAuthException catch (e) {
                      errorMessage = e.code;
                      setState(() {
                        showError = true;
                      });
                    }
                  }),
                  signUpOption()
                ]))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
