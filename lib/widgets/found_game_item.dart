import 'package:flutter/material.dart';
import 'package:gamelib_mob/api/api_services.dart';
import 'package:gamelib_mob/api/igdb_token.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';
import 'package:provider/provider.dart';

class FoundGameItem extends StatefulWidget {
  final GameItem item;
  final MainList favouriteGameList;
  const FoundGameItem(this.favouriteGameList, this.item, {super.key});

  @override
  State<FoundGameItem> createState() => _FoundGameItemState();
}

class _FoundGameItemState extends State<FoundGameItem> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<IGDBToken>(context, listen: false);
    Future<Image>? coverFuture;
    if (widget.item.cover == null) {
      coverFuture = getCover(token.accessToken, widget.item.coverId);
    } else {
      coverFuture = Future.value(widget.item.cover);
    }

    return FutureBuilder(
        future: coverFuture,
        builder: (context, AsyncSnapshot<Image> snapshot) {
          if (snapshot.hasData) {
            widget.item.cover = snapshot.data;
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return ListTile(
              leading: widget.item.buildCover(context),
              title: widget.item.buildTitle(context),
              subtitle: widget.item.buildSubtitle(context),
              trailing: HeartButton(widget.favouriteGameList, widget.item),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GameDetailScreen(
                        widget.favouriteGameList,widget.item);
                  })));
        });
  }
}
