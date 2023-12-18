import 'package:flutter/material.dart';

class GameDetailScreen extends StatelessWidget {
  const GameDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('gamepage'),
        ), //AppBar
        body: SizedBox(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      "call gamelist",
                    ), //Text
                    onPressed: () {},
                  ), //RaisedButton
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text("Name "),
                    onPressed: () {},
                  ), //RaisedButton
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      "Score",
                    ),
                    onPressed: () {},
                  ), //Text
                ])));
  }
}
