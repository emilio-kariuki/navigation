import "package:flutter/material.dart";
import 'Accounts.dart';
import 'Post.dart';
import 'Home.dart';

class Navi extends StatefulWidget {
  Navi({Key? key}) : super(key: key);

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int selectedIndex = 0;
  List<Widget> pages = [
    Home(),
    Post(),
    Accounts(),
  ];
  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Accounts"),
        ],
      ),
    );
  }
}
