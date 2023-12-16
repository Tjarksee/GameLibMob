import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/post_request.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/search_result.dart';
import 'package:gamelib_mob/helpers/helpers.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:provider/provider.dart';

class SearchGameScreen extends StatefulWidget {
  final MainList favouriteGameList;

  const SearchGameScreen({super.key, required this.favouriteGameList});

  @override
  State<SearchGameScreen> createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends State<SearchGameScreen> {
  late Future<IGDBToken> token;
  @override
  void initState() {
    super.initState();
    token = fetchIGDBToken();
  }

  late MainList favouriteGameList = widget.favouriteGameList;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchInfo = TextEditingController();
    Future<List<GameItem>> searchResultList;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a Game'),
        ),
        body: FutureBuilder<IGDBToken>(
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
                              reusableTextField("Game Name", Icons.games,
                                  false, searchInfo),
                              firebaseUIButton(context, "search", () {
                                searchResultList = getGameItem(
                                  Provider.of<Future<IGDBToken>>(context,
                                      listen: false),
                                  searchInfo.text,
                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchResultScreen(
                                                gameList: searchResultList,
                                                favouriteGameList:
                                                    favouriteGameList)));
                              })
                            ]))));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }));
  }
}
