import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../wifi/wifi_config_modal.dart';
import '../modals/status_modal.dart';

class ConfigureDeviceScreen extends StatefulWidget {
  @override
  _ConfigureDeviceScreenState createState() => _ConfigureDeviceScreenState();
}

class _ConfigureDeviceScreenState extends State<ConfigureDeviceScreen> {
  String selectedSsid = '';
  String password = '';
  bool isConnecting = false;

  Future<void> _connectToWifi() async {
    if (selectedSsid.isEmpty || password.isEmpty) return;
    setState(() => isConnecting = true);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.4.1:5000/connect-wifi'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'ssid': selectedSsid, 'password': password}),
      );
      final data = json.decode(response.body);

      showDialog(
        context: context,
        builder: (_) => StatusModal(
          icon: data['status'] == 'connected'
              ? Icons.check_circle_outline
              : Icons.error_outline,
          title: data['status'] == 'connected' ? 'Success' : 'Error',
          message: data['status'] == 'connected'
              ? 'Successfully connected to Wi-Fi!'
              : 'Failed to connect. Please try again.',
          closable: true,
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => const StatusModal(
          icon: Icons.error_outline,
          title: 'Error',
          message: 'Connection failed. Please try again.',
          closable: true,
        ),
      );
    } finally {
      setState(() => isConnecting = false);
    }
  }

  void _openWifiConfigModal() async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => WifiConfigModal(),
    );

    if (result != null) {
      setState(() {
        selectedSsid = result['ssid'] ?? '';
        password = result['password'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Your Device'),
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
              subtitle: Text(selectedSsid.isEmpty ? 'Not configured' : 'SSID: \$selectedSsid'),
              onTap: _openWifiConfigModal,
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Developer Mode'),
              subtitle: Text('Disabled'),
              trailing: Switch(value: false, onChanged: null),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: isConnecting ? null : _connectToWifi,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isConnecting
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Loading', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    )
                  : Text('Load Configuration', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
