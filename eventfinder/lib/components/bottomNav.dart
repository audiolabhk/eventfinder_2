import 'package:flutter/material.dart';
import '../main.dart';
import '../Explore.dart';
import '../Favorites.dart';

Widget bottomNav(context) {

  List<Widget> _pages = [Main(),Explore(),Favorites()];
  _handleTap(index){
    Navigator.push(context,MaterialPageRoute(builder: (context) => _pages[index]));
    }

  return BottomNavigationBar(
    currentIndex: 0,
    selectedFontSize: 40,
    unselectedFontSize: 20,
    type: BottomNavigationBarType.fixed,
    onTap: (index) => _handleTap(index),
    items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text("Explore")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("Favorites")),
  ]);
  }