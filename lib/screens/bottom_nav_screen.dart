import 'package:covid19/screens/home_screen.dart';
import 'package:covid19/services/utils.dart';
import 'package:covid19/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = '/bottom-nav-screen';

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    HomeScreen(),
    // StatsScreen(),
    Scaffold(
      appBar: CustomAppBar(),
    ),
    Scaffold(
      appBar: CustomAppBar(),
    ),

    Scaffold(
      appBar: CustomAppBar(),
    ),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple[50],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        // selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [Icons.home, Icons.insert_chart, Icons.event_note, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    label: '',
                    activeIcon: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndex == value
                            ? Colors.blue
                            : CommonColor.primaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value, color: Colors.white),
                    ),
                    // backgroundColor: Colors.teal,
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndex == value
                            ? Colors.blue
                            : CommonColor.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(
                        value,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }
}
