import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/game_item.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/search_game.dart';
import 'package:gamelib_mob/screens/game_detail.dart';
import 'package:gamelib_mob/screens/sign_in.dart';
import 'package:gamelib_mob/helpers/helpers.dart';
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
      profilePage(context, "tefdsf", ['1', '2', '3']),
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
              leading: favouriteGameList[index].buildLeading(context),
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
                    const IconButton(
                        onPressed: (null),
                        icon: Icon(Icons.filter_alt_rounded)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchGameScreen(
                                      favouriteGameList:
                                          mainList))).then((_) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.search)),
                    const IconButton(
                        onPressed: (null),
                        icon: Icon(Icons.format_list_bulleted_sharp))
                  ],
                ),
                drawer: Drawer(
                    child: ListView(
                  children: [
                    const SizedBox(
                      height: 64.0,
                      child: DrawerHeader(
                          margin: EdgeInsets.all(0.0),
                          padding: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 113, 113, 113)),
                          child: Center(
                            child: Text("menu", textAlign: TextAlign.center),
                          )),
                    ),
                    ListTile(
                      title: const Text(
                        'Logout',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Item 2', textAlign: TextAlign.center),
                      onTap: () {},
                    )
                  ],
                )),
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
