import 'package:flutter/material.dart';
import '../second_screen.dart';
import 'device_status_screen.dart';
import 'activate_device_screen.dart';
import 'package:wifi_scan/wifi_scan.dart';

class MainScreen extends StatefulWidget {  // Changed to StatefulWidget
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isScanning = false;
  List<WiFiAccessPoint> _devices = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this key
  final _scanDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  Future<void> _scanDevices() async {
    setState(() => _isScanning = true);
    _devices = [];
    
    final canScan = await WiFiScan.instance.canStartScan();
    if (canScan == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      await Future.delayed(_scanDuration);
      final results = await WiFiScan.instance.getScannedResults();
      setState(() {
        _devices = results;
        _isScanning = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: _buildMenuButton(),
        toolbarHeight: 80,
        title: Text('SceneScribe'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/logo.png',
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      // Add drawer property here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                Image.asset(
                  'assets/logo.png', // Path to your image
                  width: 80,        // Adjust width
                  height: 80,       // Adjust height
                  fit: BoxFit.contain, // How to fit the image
                ),
                SizedBox(height: 10),
                Text(
                'Device Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),],) 
             
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search for Devices'),
              // onTap: () {
              //   // Close the drawer first
              //   Navigator.pop(context);
              //   // Then navigate to search screen (you'll need to create this)
              //   Navigator.push(context, MaterialPageRoute(builder: (_) => SearchDevicesScreen()));
              // },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Activate Your Device'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => ActivateDeviceScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Check Device Status'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => DeviceStatusScreen()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: GestureDetector(
              onTap: _isScanning ? null : _scanDevices,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _isScanning ? 120 : 80,
                height: _isScanning ? 120 : 80,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: _isScanning
                    ? _buildScanningAnimation()
                    : Icon(Icons.search, size: 40, color: Colors.blue),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            _isScanning 
                ? 'Scanning for devices...'
                : 'Tap the magnifier to search',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 30),
          Expanded(
            child: _devices.isEmpty
                ? Center(child: Text('No devices found'))
                : ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: (context, index) {
                      final device = _devices[index];
                      return ListTile(
                        leading: Icon(Icons.wifi),
                        title: Text(device.ssid),
                        subtitle: Text('Signal: ${device.level}dBm'),
                        trailing: Icon(Icons.signal_cellular_alt,
                            color: _getSignalColor(device.level)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

    // 5. Bulletproof menu button implementation
  Widget _buildMenuButton() {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          debugPrint("Menu button pressed"); // Debug confirmation
          _scaffoldKey.currentState?.openDrawer(); // Guaranteed to work
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),)
            ],
          ),
          child: Icon(Icons.menu, color: Colors.blue),
        ),
      ),
    );
  }
  Widget _buildScanningAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...List.generate(3, (index) {
          return ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(index * 0.2, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5 - (index * 0.15)),
                  width: 2,
                ),
              ),
            ),
          );
        }),
        Icon(Icons.search, size: 40, color: Colors.blue),
      ],
    );
  }

  Color _getSignalColor(int level) {
    final strength = level.abs();
    if (strength <= 50) return Colors.green;
    if (strength <= 70) return Colors.yellow;
    return Colors.red;
  }
}