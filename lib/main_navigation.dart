// main_navigation.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/device_status_screen.dart';
import 'screens/activate_device_screen.dart';

class MainNavigationWrapper extends StatefulWidget {
  @override
  _MainNavigationWrapperState createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(), // Your existing main screen (now HomeScreen)
    DeviceStatusScreen(), // New devices tab
    ProfileTabScreen(), // New profile tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon('assets/vr_icon.png', isActive: _currentIndex == 1),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCustomIcon(String assetPath, {bool isActive = false}) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isActive ? Colors.blue : Colors.grey, // Active/inactive colors
        BlendMode.srcIn, // Applies color to all non-transparent pixels
      ),
      child: Image.asset(
        assetPath,
        width: 24, // Standard icon size
        height: 24,
      ),
    );
  }
}

class ProfileTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile information content')),
    );
  }
}

