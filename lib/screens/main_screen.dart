import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/bottom_navbar.dart';
import 'package:news/screens/tabs/home_screen.dart';
import 'package:news/screens/tabs/search_screen.dart';
import 'package:news/screens/tabs/sources_screen.dart';
import 'package:news/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    _bottomNavBarBloc = BottomNavBarBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text(
            "NewsApp",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItems>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultIteam,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case NavBarItems.HOME:
                return HomeScreen();
              case NavBarItems.SOURCES:
                return SourceScreen();

              case NavBarItems.SEARCH:
                return SearchScreen();
              default:
                return HomeScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultIteam,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 0,
                  blurRadius: 10.0,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.Colors.mainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(
                      EvaIcons.homeOutline,
                    ),
                    activeIcon: Icon(
                      EvaIcons.home,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Sources",
                    icon: Icon(
                      EvaIcons.gridOutline,
                    ),
                    activeIcon: Icon(
                      EvaIcons.grid,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Search",
                    icon: Icon(
                      EvaIcons.searchOutline,
                    ),
                    activeIcon: Icon(
                      EvaIcons.search,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Test Screen"),
        ],
      ),
    );
  }
}
