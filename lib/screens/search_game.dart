import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/get_game_item.dart';
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
  late IGDBToken? token;
  @override
  void initState() {
    super.initState();
  }

  late MainList favouriteGameList = widget.favouriteGameList;
  @override
  Widget build(BuildContext context) {
    token = Provider.of<IGDBToken?>(context, listen: true);
    const List<Color> backgroundColors = [
      Color.fromARGB(249, 50, 48, 50),
      Color.fromARGB(249, 108, 106, 108),
      Color.fromARGB(249, 50, 48, 50),
    ];
    TextEditingController searchInfo = TextEditingController();
    Future<List<GameItem>> searchResultList;
    if(token!=null){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a Game'),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: backgroundColors,
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft)),
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.025, 20, 0),
            child: Column(children: <Widget>[
              reusableTextField("Game Name", Icons.games, false, searchInfo),
              firebaseUIButton(context, "search", () {
                searchResultList = getGameItem(
                  token!,
                  searchInfo.text,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                            gameList: searchResultList,
                            favouriteGameList: favouriteGameList)));
              })
            ])));
    } 
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
  }
}
