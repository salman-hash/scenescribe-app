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
    AboutTabScreen(), // New profile tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,      
        selectedItemColor: Colors.blue, // Dark blue for selected
        unselectedItemColor: Colors.grey, // Medium grey for unselected
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
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

class AboutTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SceneScribe VR Device', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Our VR device features:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            _buildBulletPoint('90Hz refresh rate'),
            _buildBulletPoint('6DoF tracking'),
            _buildBulletPoint('4K resolution per eye'),
            SizedBox(height: 20),
            Text('Version: 2.3.1', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

