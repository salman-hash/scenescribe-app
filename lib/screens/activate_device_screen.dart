import 'package:flutter/material.dart';

class ActivateDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activate Your Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/vr_device.png', height: 150),
            ),
            SizedBox(height: 20),
            Text(
              'VR-X2000 Headset',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 8),
                Text('Connected', style: TextStyle(color: Colors.green)),
              ],
            ),
            Divider(height: 30),
            Text(
              'Device Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('API Key'),
              subtitle: Text('***************', style: TextStyle(letterSpacing: 3)),
              trailing: Icon(Icons.lock),
            ),
            ListTile(
              leading: Icon(Icons.wifi),
              title: Text('WiFi Settings'),
              subtitle: Text('Connected to HomeNetwork'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Developer Mode'),
              subtitle: Text('Disabled'),
              trailing: Switch(value: false, onChanged: null),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Activation logic
              },
              child: Text('Activate Device'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}