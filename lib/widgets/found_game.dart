import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';

class FoundGame extends StatefulWidget {
  final GameItem item;
  final MainList favouriteGameList;
  const FoundGame(this.favouriteGameList, this.item, {super.key});

  @override
  State<FoundGame> createState() => _FoundGameState();
}

class _FoundGameState extends State<FoundGame> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: widget.item.buildLeading(context),
        title: widget.item.buildTitle(context),
        subtitle: widget.item.buildSubtitle(context),
        trailing: HeartButton(widget.favouriteGameList, widget.item),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const GameDetailScreen();
            })));
  }
}