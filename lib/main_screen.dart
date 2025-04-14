import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Your actual content goes here
            Center(child: Text("Main App Content")),

            // App icon in the top-right corner
            Positioned(
              top: 16,
              right: 16,
              child: Image.asset(
                'assets/logo.png',
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
