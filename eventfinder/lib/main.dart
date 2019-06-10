import 'package:flutter/material.dart';
import './Explore.dart';
import './Favorites.dart';
import './Home.dart';

void main() => runApp(EventApp());

class EventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Main());
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _navIndex;

  final pc = PageController(initialPage: 0);
  Widget pv() {
    return PageView(
      controller: pc,
      children: <Widget>[Home(), Explore(), Favorites()],
      onPageChanged: (index) => _setStupidIconColor(index),
    );
  }


  void _setStupidIconColor(index) {
    setState(() {
      _navIndex = index;
    });
  }
  void _handleTap(index) {
    setState(() {
      pc.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 20,
      ),
      body: pv(),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          unselectedItemColor: Colors.white,
          currentIndex: _navIndex,
          onTap: (index) => _handleTap(index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), title: Text("Explore")),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text("Favorites")),
          ]),
    );
  }
}
