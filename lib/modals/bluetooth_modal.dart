import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BluetoothModal extends StatefulWidget {
  const BluetoothModal({super.key});

  @override
  State<BluetoothModal> createState() => _BluetoothModalState();
}

class _BluetoothModalState extends State<BluetoothModal> {
  bool _loading = true;
  List<String> _devices = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final res = await http.get(Uri.parse('http://192.168.4.1:5000/scan-bluetooth'));
      final data = json.decode(res.body);

      if (res.statusCode == 200 && data['devices'] != null) {
        setState(() {
          _devices = List<String>.from(data['devices']);
          _loading = false;
        });
      } else {
        setState(() => _error = 'Failed to retrieve devices.');
      }
    } catch (e) {
      setState(() => _error = 'Error: $e');
    }
  }

  void _pairDevice(String deviceName) async {
    Navigator.of(context).pop(); // Close modal
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Pairing...'),
        content: Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: false,
    );

    try {
      final res = await http.post(
        Uri.parse('http://192.168.4.1:5000/pair-bluetooth'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"device": deviceName}),
      );

      final data = json.decode(res.body);
      Navigator.of(context).pop(); // Close loading

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(data['status'] == 'paired' ? 'Success' : 'Failed'),
          content: Text(data['message'] ?? 'No message'),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to pair: $e"),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bluetooth Devices'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(_devices[index]),
                        onTap: () => _pairDevice(_devices[index]),
                      );
                    },
                  ),
      ),
    );
  }
}
