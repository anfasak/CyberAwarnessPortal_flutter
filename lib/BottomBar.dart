 import 'package:cyberguard/HomePage.dart';
import 'package:cyberguard/ProfilePage.dart';
import 'package:cyberguard/SendComplaint.dart';
import 'package:cyberguard/SendFeedback.dart';
import 'package:flutter/material.dart';



class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
   Profilepage(),
   SendFeedback(),
   SendComplaint(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "feedback",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: "complaint",
          ),
        ],
      ),
    );
  }
}
