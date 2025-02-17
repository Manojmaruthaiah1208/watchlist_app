import 'package:flutter/material.dart';
import 'package:watch_list_app/core/constants/app_constants.dart';
import 'watchlist/watchlist_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    Center(child: Text(AppConstants.homeScreen, style: TextStyle(fontSize: 24))),
    WatchlistScreen(),
    Center(child: Text(AppConstants.settingsScreen, style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppConstants.home),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: AppConstants.watchList),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppConstants.settings),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
