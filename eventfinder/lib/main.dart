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
  Widget _activePage = Home();
  String _activeTitle = "Home";
  List<String> titles = ['Home', 'Explore', 'Favorites'];
  List<Widget> _pages = [Home(), Explore(), Favorites()];
  int _navIndex = 0;

  void _handleTap(index) {
    setState(() {
      _navIndex = index;
      _activePage = _pages[index];
      _activeTitle = titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_activeTitle),
      ),
      body: _activePage,
      bottomNavigationBar:
        BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: (index) => _handleTap(index), items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.explore), title: Text("Explore")),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), title: Text("Favorites")),
      ]),
    );
  }
}
