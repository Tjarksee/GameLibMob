import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/main_list.dart';

import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:gamelib_mob/screens/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(providers: [
    FutureProvider<IGDBToken?>(
      create: (_) => fetchIGDBToken(),
      initialData: null,
    ),
    ChangeNotifierProvider(create: (context) => MainList())
  ], 
      child: const MyApp(),
  )
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
        home: const SignInScreen());
  }
}
