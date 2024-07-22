import 'package:flutter/material.dart';
import 'package:questonnaire_app/core/app_constants.dart';
import 'package:questonnaire_app/screens/tab_bar/chat_bot_screen.dart';
import 'package:questonnaire_app/screens/tab_bar/label_screen.dart';
import 'package:questonnaire_app/screens/tab_bar/main_screen.dart';
import 'package:questonnaire_app/screens/tab_bar/resources_screen.dart';
import 'package:questonnaire_app/screens/tab_bar/tasks_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1;

  final List<Widget> _screens = <Widget>[
    const MainScreen(),
    const TasksScreen(),
    const ChatBotScreen(),
    const ResourcesScreen(),
    const LabelScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppConstants.tabBarColor.withOpacity(0.92),
        selectedItemColor: AppConstants.selectedTabsColor,
        unselectedItemColor: AppConstants.unselectedTabsColor.withOpacity(0.6),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/main_icon.png'),
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/tasks_icon.png'),
            ),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/chat_bot_icon.png'),
            ),
            label: 'ЧатБот',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/resources_icon.png'),
            ),
            label: 'Ресурсы',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/label_icon.png'),
            ),
            label: 'Label',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
