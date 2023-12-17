import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/profile_page.dart';
import 'package:gamelib_mob/screens/search_game.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MainList mainList = MainList();
  late List<Widget> widgetOptions;
  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  List<GameItem> favouriteGameList = [];

  void createListWidget() {
    widgetOptions = <Widget>[
      _buildMainList(),
      ProfileScreen(
        favouriteGameList: mainList,
      ),
    ];
  }

  Widget _buildMainList() {
    favouriteGameList = mainList.favouriteGameList;
    return ListView.builder(
      itemCount: favouriteGameList.length,
      itemBuilder: (BuildContext content, int index) {
        return Container(
          color: Colors.grey,
          child: ListTile(
              leading: favouriteGameList[index].buildCover(context),
              title: favouriteGameList[index].buildTitle(context),
              subtitle: favouriteGameList[index].buildSubtitle(context),
              trailing: HeartButton(mainList, favouriteGameList[index]),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const GameDetailScreen();
                  }))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    createListWidget();
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
                appBar: AppBar(
                  title: const Text('Your Game List'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchGameScreen(
                                      favouriteGameList: mainList))).then((_) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.search)),
                  ],
                ),
                body: Center(
                  child: widgetOptions.elementAt(_selectedIndex),
                ),
                bottomNavigationBar: _MyBottomNavigationBar(
                  updateIndex: changeIndex,
                  currentIndex: _selectedIndex,
                ))));
  }
}

class _MyBottomNavigationBar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final updateIndex;
  final int currentIndex;

  const _MyBottomNavigationBar({this.updateIndex, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        )
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber,
      onTap: (int index) {
        updateIndex(index);
      },
    );
  }
}
