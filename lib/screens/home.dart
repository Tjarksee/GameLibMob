import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/profile_page.dart';
import 'package:gamelib_mob/screens/search_game.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/widgets/heart_button.dart';
import 'package:gamelib_mob/firebase/firebase_traffic.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "test";
  late List<Widget> widgetOptions;

  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> getInfoFromDatabase() async {
    MainList mainList = context.watch<MainList>();

    try {
      List<GameItem> data = await FirebaseTraffic.pullFirebase();
      String name = await FirebaseTraffic.getNameFromFirebase();

      setState(() {
        userName = name;
        mainList.gameItems = data;
        mainList.username = name;
      });
    } catch (error) {}
  }

  void createListWidget() {
    widgetOptions = <Widget>[
      _buildMainList(),
      const ProfileScreen(),
    ];
  }

  Widget _buildMainList() {
    MainList mainList = context.watch<MainList>();
    return ListView.builder(
      itemCount: mainList.gameItems.length,
      itemBuilder: (BuildContext content, int index) {
        return Container(
          color: Colors.grey,
          child: ListTile(
              leading: mainList.gameItems[index].buildCover(context),
              title: mainList.gameItems[index].buildTitle(context),
              subtitle: mainList.gameItems[index].buildSubtitle(context),
              trailing: HeartButton(
                mainList.gameItems[index],
              ),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GameDetailScreen(
                      item: mainList.gameItems[index],
                    );
                  }))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getInfoFromDatabase();

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
                                  builder: (context) =>
                                      const SearchGameScreen())).then((_) {
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
