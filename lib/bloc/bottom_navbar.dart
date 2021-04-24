import 'dart:async';

enum NavBarItems { HOME, SOURCES, SEARCH }

class BottomNavBarBloc {
  final StreamController<NavBarItems> _navBarController =
      StreamController<NavBarItems>.broadcast();
  NavBarItems defaultIteam = NavBarItems.HOME;
  Stream<NavBarItems> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItems.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItems.SOURCES);
        break;
      case 2:
        _navBarController.sink.add(NavBarItems.SEARCH);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
