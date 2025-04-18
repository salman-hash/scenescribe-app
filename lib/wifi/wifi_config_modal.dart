import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WifiConfigModal extends StatefulWidget {
  @override
  _WifiConfigModalState createState() => _WifiConfigModalState();
}

class _WifiConfigModalState extends State<WifiConfigModal> {
  List<String> ssids = [];
  String? selectedSsid;
  String password = '';
  bool isLoading = false;

  Future<void> scanWifi() async {
    setState(() {
      isLoading = true;
      ssids = [];
      selectedSsid = null;
      password = '';
    });

    try {
      final response = await http.get(Uri.parse('http://192.168.4.1:5000/scan-wifi'));
      final data = json.decode(response.body);
      setState(() {
        ssids = List<String>.from(data['networks']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ssids = [];
      });
    }
  }

  void selectSsid(String ssid) {
    setState(() {
      selectedSsid = ssid;
      ssids = [];
    });
  }

  void submit() {
    if (selectedSsid != null && password.isNotEmpty) {
      Navigator.pop(context, {
        'ssid': selectedSsid,
        'password': password,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;

    return Container(
      height: height,
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wi-Fi Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: scanWifi,
                icon: Icon(Icons.wifi_find, color: Colors.blue),
                label: Text("Scan", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (ssids.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: ssids.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(ssids[index]),
                  onTap: () => selectSsid(ssids[index]),
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text: selectedSsid),
                    decoration: InputDecoration(labelText: 'SSID'),
                    readOnly: true,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) => password = value,
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: submit,
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
