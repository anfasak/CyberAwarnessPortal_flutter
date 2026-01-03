import 'package:cyberguard/HomePage.dart';
import 'package:cyberguard/ProfilePage.dart';
import 'package:cyberguard/Quiz.dart';
import 'package:cyberguard/SendComplaint.dart';
import 'package:cyberguard/SendFeedback.dart';
import 'package:flutter/material.dart';

class BottomBarPagehelp extends StatefulWidget {
  const BottomBarPagehelp({super.key});

  @override
  State<BottomBarPagehelp> createState() => _BottomBarPagehelpState();
}

class _BottomBarPagehelpState extends State<BottomBarPagehelp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [SendFeedback(), SendComplaint()];

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
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: "feedback"),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: "complaint",
          ),
        ],
      ),
    );
  }
}
