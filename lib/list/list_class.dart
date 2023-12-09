import 'package:flutter/material.dart';
import 'package:gamelib_mob/helpers/game_class.dart';

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  Widget buildLeading(BuildContext context);

  Widget buildTrailing(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class GameItem implements ListItem {
  GameInfo gameItemInfo;

  GameItem(this.gameItemInfo);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      gameItemInfo.name,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();

  @override
  Widget buildLeading(BuildContext context) {
    //TODO
    return gameItemInfo.cover;
    //return const SizedBox.shrink();
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);

  @override
  Widget buildLeading(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }
}