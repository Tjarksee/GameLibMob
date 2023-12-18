import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_item.dart';

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
  Widget buildCover(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox.shrink();
  }
}
