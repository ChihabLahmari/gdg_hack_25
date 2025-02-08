import 'package:flutter/material.dart';
import 'package:my_template/core/theming/colors.dart';
import 'package:my_template/features/home/ui/hackathons_screen.dart';
import 'package:my_template/features/home/ui/home_screen.dart';
import 'package:my_template/features/home/ui/network_screen.dart';
import 'package:my_template/features/home/ui/profile_screen.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0; // Index of the selected tab

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    const HomeScreen(),
    NetworkPage(),
     HackathonsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsManager.white,
        currentIndex: _selectedIndex, // Highlight the selected tab
        onTap: _onItemTapped, // Handle tab selection
        type: BottomNavigationBarType.fixed, // Ensure all tabs are visible
        fixedColor: ColorsManager.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Network',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Hackathons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
