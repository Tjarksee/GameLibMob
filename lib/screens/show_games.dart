import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/helpers/game_info.dart';
import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/screens/game_detail.dart';

class AddGameListScreen extends StatefulWidget {
  final Future<List<GameInfo>> gameList;
  final MainList favouriteGameList;
  const AddGameListScreen(
      {Key? key, required this.gameList, required this.favouriteGameList})
      : super(key: key);

  @override
  State<AddGameListScreen> createState() => _AddGameListScreenState();
}

class _AddGameListScreenState extends State<AddGameListScreen> {
  late Future<List<GameInfo>> token = widget.gameList;
  late MainList favouriteGameList = widget.favouriteGameList;

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder<List<GameInfo>>(
                future: token,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final listOfItems = List<GameItem>.generate(
                        snapshot.data!.length,
                        (i) => GameItem(snapshot.data![i]));
                    return Scaffold(
                      body: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          final GameItem item = listOfItems[index];

                          bool alreadyInList = favouriteGameList.contains(item);

                          return ListTile(
                              leading: item.buildLeading(context),
                              title: item.buildTitle(context),
                              subtitle: item.buildSubtitle(context),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (alreadyInList) {
                                      favouriteGameList.removeFavourite(item);
                                    } else {
                                      favouriteGameList.addFavourite(item);
                                    }
                                  });
                                },
                                icon: Icon(
                                  alreadyInList
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: alreadyInList ? Colors.red : null,
                                ),
                              ),
                              onTap: () => Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const GameDetailScreen();
                                  })));
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    if (snapshot.error.toString() ==
                        'Exception: No Games Found') {
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
                        child: const Center(
                          child: Text(
                            'No Games Found',
                            textScaleFactor: 2,
                          ),
                        ),
                      ));
                    } else {
                      return Text('${snapshot.error}');
                    }
                  }
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                })));
  }
}
