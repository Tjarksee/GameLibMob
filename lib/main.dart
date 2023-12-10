import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/screens/home.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:gamelib_mob/screens/sign_in.dart';
import 'package:gamelib_mob/api/igdb_token.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Provider(create: (_) => fetchIGDBToken(), child: MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Game List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const SignInScreen());
        home: const HomeScreen());
  }
}
