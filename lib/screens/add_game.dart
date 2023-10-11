import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/post_request.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/add_game_list.dart';
import 'package:gamelib_mob/helpers/game_class.dart';
import 'package:gamelib_mob/helpers/helpers.dart';
import 'package:gamelib_mob/api/idgb_token.dart';

class AddGameScreen extends StatefulWidget {
  final MainList favList;

  const AddGameScreen({super.key, required this.favList});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  late Future<IGDBToken> token;
  @override
  void initState() {
    super.initState();
    token = fetchIGDBToken();
  }

  late MainList favedList1 = widget.favList;
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchInfo = TextEditingController();
    Future<List<GameInfo>> gameList1;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a Game'),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(249, 50, 48, 50),
                  Color.fromARGB(249, 108, 106, 108),
                  Color.fromARGB(249, 50, 48, 50)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
            child: FutureBuilder<IGDBToken>(
                future: token,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Scaffold(
                        body: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(249, 50, 48, 50),
                                      Color.fromARGB(249, 108, 106, 108),
                                      Color.fromARGB(249, 50, 48, 50)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft)),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20,
                                    MediaQuery.of(context).size.height * 0.025,
                                    20,
                                    0),
                                child: Column(children: <Widget>[
                                  reusableTextField("Search Gameß", Icons.games,
                                      false, _searchInfo),
                                  firebaseUIButton(context, "search", () {
                                    gameList1 = getGameInfo(
                                        snapshot.data!.access_token,
                                        _searchInfo.text);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddGameListScreen(
                                                    gameList: gameList1,
                                                    favList: favedList1)));
                                  })
                                ]))));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Scaffold(
                    body: Center(child: const CircularProgressIndicator()),
                  );
                })));
  }
}