import 'package:flutter/material.dart';
import 'second_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SecondScreen()),
                );
              },
              child: Text("Go to Second Screen"),
            ),
          ),
          Positioned(
            top: 25,
            left: 25,
            child: Image.asset('assets/logo.png', width: 100),
          ),
        ],
      ),
    );
  }
}
