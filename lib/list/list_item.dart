import 'package:flutter/material.dart';

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  Widget buildCover(BuildContext context);

  Widget buildTrailing(BuildContext context);
}
