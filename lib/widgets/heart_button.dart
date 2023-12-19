import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';

class HeartButton extends StatefulWidget {
  final GameItem item;
  final MainList favouriteGameList;
  const HeartButton(this.favouriteGameList, this.item, {super.key});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    final bool alreadyInList = widget.favouriteGameList.contains(widget.item);
    return IconButton(
      onPressed: () {
        setState(() {
          if (alreadyInList) {
            widget.favouriteGameList.removeFavourite(widget.item);
          } else {
            widget.favouriteGameList.addFavourite(widget.item);
          }
        });
      },
      icon: Icon(
        alreadyInList ? Icons.favorite : Icons.favorite_border,
        color: alreadyInList ? Colors.red : Colors.grey,
      ),
    );
  }
}
