import 'package:flutter/material.dart';
import 'configure_device_screen.dart';
class DeviceStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Status'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Device Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'VR-X2000 Status',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text('Online', style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatusItem(Icons.battery_full, '85%', 'Battery'),
                          _buildStatusItem(Icons.memory, 'Normal', 'Performance'),
                          _buildStatusItem(Icons.storage, '64GB', 'Storage'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Activation Button (simplified)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Add activation logic here
                    print('Device Configuration Screen initiated');
                    // Or navigate to activation screen:
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => ConfigureDeviceScreen()));
                  },
                  child: Text(
                    'Configure Device',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 10),
              // Function Cards
              _buildFunctionCard(
                'Performance Metrics',
                [
                  _buildMetricItem('Frame Rate', '90 FPS'),
                  _buildMetricItem('Latency', '22ms'),
                  _buildMetricItem('Temperature', '38°C'),
                ],
              ),
              
              SizedBox(height: 10),
              
              _buildFunctionCard(
                'Tracking Status',
                [
                  _buildMetricItem('Head Tracking', 'Active'),
                  _buildMetricItem('Controller 1', 'Connected'),
                  _buildMetricItem('Controller 2', 'Connected'),
                  _buildMetricItem('Eye Tracking', 'Enabled'),
                ],
              ),
              
              SizedBox(height: 10),
              
              _buildFunctionCard(
                'Session Info',
                [
                  _buildMetricItem('Current Session', '1h 24m'),
                  _buildMetricItem('Today', '2h 10m'),
                  _buildMetricItem('This Week', '8h 45m'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildFunctionCard(String title, List<Widget> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(children: items),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}