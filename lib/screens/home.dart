import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamelib_mob/list/list_class.dart';
import 'package:gamelib_mob/list/main_list.dart';
import 'package:gamelib_mob/screens/add_game.dart';
import 'package:gamelib_mob/screens/game_page.dart';
import 'package:gamelib_mob/screens/signIn.dart';
import 'package:gamelib_mob/helpers/helpers.dart';
import 'package:gamelib_mob/firebase_traffic.dart';
import 'package:gamelib_mob/list/main_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MainList favedList1 = MainList(userId: '');
  late List<Widget> widgetOptions;
  void changeIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

 List<GameItem> mainLists = [];

  update(favList) {
    MainList items = favList;
    mainLists = items.favList;
  }
  late Future<List<GameItem>> futureFavGameList;


  void initState() {
    super.initState();
    //Load from DB
    print("test");
    futureFavGameList = FirebaseTraffic.pullFirebase();
  }

  Widget buildMainList() {
    return FutureBuilder<List<GameItem>>(
      future: futureFavGameList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available.');
        } else {
          List<GameItem> mainLists = snapshot.data!;
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => game_page()),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void createListWidget() {
    widgetOptions = <Widget>[
      _buildMainList(),
      profilePage(context, "tefdsf", ['1', '2', '3']),
    ];
  }

  Widget _buildMainList() {

    update(favedList1);
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
                  title: Text('title'),
                  actions: [
                    IconButton(
                        onPressed: (null),
                        icon: Icon(Icons.filter_alt_rounded)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddGameScreen(favList: favedList1)))
                              .then((_) {
                            setState(() {});
                          });
                        },
                        icon: Icon(Icons.search)),
                    IconButton(
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
                              print("Signed Out");
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