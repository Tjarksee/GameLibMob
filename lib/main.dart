import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/screens/home.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    FutureProvider<IGDBToken?>(
      create: (_) => fetchIGDBToken(),
      initialData: null,
      child: const MyApp(),
    ),
  );
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
        home: const HomeScreen());
        //home: const SignInScreen());
  }
}
