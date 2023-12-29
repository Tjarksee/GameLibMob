
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:provider/provider.dart';

class HeartButton extends StatefulWidget {
  final GameItem item;
  const HeartButton(this.item, {super.key});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    MainList mainList = context.watch<MainList>();
    final bool alreadyInList = mainList.contains(widget.item);
    return IconButton(
      onPressed: () {
        setState(() {
          if (alreadyInList) {
            mainList.removeFavourite(widget.item);
          } else {
            mainList.addFavourite(widget.item);
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