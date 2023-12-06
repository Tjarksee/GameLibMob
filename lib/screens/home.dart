import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/add_game.dart';
import 'package:gamelib_mob/screens/game_page.dart';
import 'package:gamelib_mob/screens/sign_in.dart';
import 'package:gamelib_mob/screens/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MainList favouriteGameList = MainList();
  late List<Widget> widgetOptions;
  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  List<GameItem> mainLists = [];

  update(favouriteGameList) {
    MainList items = favouriteGameList;
    mainLists = items.favouriteGameList;
  }

  void createListWidget() {
    widgetOptions = <Widget>[
      _buildMainList(),
      ProfileScreen(),
    ];
  }

  Widget _buildMainList() {
    update(favouriteGameList);
    return ListView.builder(
      itemCount: mainLists.length,
      itemBuilder: (BuildContext content, int index) {
        return Container(
          color: Colors.grey,
          child: ListTile(
              leading: mainLists[index].buildLeading(context),
              title: mainLists[index].buildTitle(context),
              subtitle: mainLists[index].buildSubtitle(context),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return game_page();
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
                                  builder: (context) => AddGameScreen(
                                      favouriteGameList:
                                          favouriteGameList))).then((_) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.search)),
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
                                  builder: (context) => SignInScreen()));
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
  final updateIndex;
  final currentIndex;

  const _MyBottomNavigationBar({this.updateIndex, this.currentIndex});

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
