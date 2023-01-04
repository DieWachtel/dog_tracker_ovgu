import 'package:flutter/material.dart';
import 'package:tracker_app/pages/Home Page/MyHomePage.dart';
import 'package:tracker_app/pages/Profile Page/MyProfilePage.dart';


class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({Key key, this.currentIndex}) : super(key: key);
  int currentIndex;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyBottomNavigationBar> {
  final List<Widget> _children = [
    MyHomePage(),
    MyProfilePage(), //same here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.shifting,
          iconSize: 35,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.grey[200],
          unselectedItemColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Home',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Profile',
                backgroundColor: Colors.blue),
          ],
          onTap: (index) {
            setState(() {
              widget.currentIndex = index;
            });
          }),
    );
  }
}
