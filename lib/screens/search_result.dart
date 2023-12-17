import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/widgets/found_game_item.dart';

class SearchResultScreen extends StatefulWidget {
  final Future<List<GameItem>> gameList;
  final MainList favouriteGameList;
  const SearchResultScreen(
      {Key? key, required this.gameList, required this.favouriteGameList})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late Future<List<GameItem>> gameList = widget.gameList;
  late MainList favouriteGameList = widget.favouriteGameList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a Game'),
        ),
        body: FutureBuilder<List<GameItem>>(
            future: gameList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final listOfItems = List<GameItem>.generate(
                    snapshot.data!.length, (i) => snapshot.data![i]);
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, int index) {
                    final GameItem item = listOfItems[index];

                    return FoundGameItem(favouriteGameList, item);
                  },
                );
              } else if (snapshot.hasError) {
                if (snapshot.error.toString() == 'Exception: No Games Found') {
                  return Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(249, 50, 48, 50),
                      Color.fromARGB(249, 108, 106, 108),
                      Color.fromARGB(249, 50, 48, 50)
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                    child: const Center(
                      child: Text(
                        'No Games Found',
                        textScaleFactor: 2,
                      ),
                    ),
                  );
                } else {
                  return Text('${snapshot.error}');
                }
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }));
  }
}
