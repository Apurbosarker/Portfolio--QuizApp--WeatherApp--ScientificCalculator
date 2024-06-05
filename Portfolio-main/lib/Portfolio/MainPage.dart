import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/Portfolio/Widgets/profile_page.dart';
import 'package:portfolio/Portfolio/Widgets/setting_page.dart';

import 'AppTheme.dart';
import 'HomePages.dart';
import '../main.dart';

class PortfolioMainPage extends StatefulWidget {
  const PortfolioMainPage({super.key});

  @override
  _PortfolioMainPageState createState() => _PortfolioMainPageState();
}

class _PortfolioMainPageState extends State<PortfolioMainPage> {
  static bool _isDarkMode = false;
  int a = 0;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // _updateTheme();
  }

  // void _updateTheme() {
  //   runApp(const MyApp());
  //   setState(() {
  //     if (_isDarkMode) {
  //       // Apply dark theme
  //       MyAppTheme.applyDarkTheme();
  //     } else {
  //       // Apply light theme
  //       MyAppTheme.applyLightTheme();
  //     }
  //   });
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // Pages for each tab
          PortfolioHomePage(isDarkMode: _isDarkMode),
          ProfilePage(isDarkMode: _isDarkMode),
          SettingPage(isDarkMode: _isDarkMode),

          const Center(child: Text('Settings Page')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
            // _updateTheme();
            print("Theme changed to ${_isDarkMode ? 'Dark' : 'Light'} $a");
            // runApp(const MyApp());
            a++;
          });
          // window.scheduleFrame();
        },
        child: const Icon(Icons.lightbulb),
      ),
    );
  }
}
