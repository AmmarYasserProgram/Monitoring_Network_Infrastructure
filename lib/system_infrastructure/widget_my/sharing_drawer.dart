import 'package:flutter/material.dart';
import 'package:project_futter_m_3/system_infrastructure/dashboard.dart';
import 'package:project_futter_m_3/device_scanner/scanning_devices.dart';
import 'package:project_futter_m_3/port_scanner/port_scanner.dart';

import '../../settings.dart';
import '../terminalPage.dart';

class SharingDrawer extends StatelessWidget {
  const SharingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0A1730)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.network_check, size: 45, color: Colors.blue),
                SizedBox(height: 15),
                Text(
                  "Network Monitor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            onTap: () {
              String? pageName = ModalRoute.of(context)?.settings.name;
              if (pageName != 'Dashboard') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'Dashboard'),
                    builder: (context) => Dashboard(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            leading: const Icon(Icons.dashboard, color: Color(0xFF0A1730)),
            title: const Text(
              "Dashboard",
              style: TextStyle(color: Color(0xFF0A1730)),
            ),
          ),

          ListTile(
            onTap: () {
              String? pageName = ModalRoute.of(context)?.settings.name;
              if (pageName != 'ScanningDevices') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'ScanningDevices'),
                    builder: (context) => ScanningDevices(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            leading: const Icon(Icons.devices, color: Color(0xFF0A1730)),
            title: const Text(
              "Scanning Devices",
              style: TextStyle(color: Color(0xFF0A1730)),
            ),
          ),

          ListTile(
            onTap: () {
              String? pageName = ModalRoute.of(context)?.settings.name;
              if (pageName != 'ScanningPortDevice') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'PortScanner'),
                    builder: (context) => PortScannerPage(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            leading: const Icon(Icons.manage_search, color: Color(0xFF0A1730)),
            title: const Text(
              "PortScanner",
              style: TextStyle(color: Color(0xFF0A1730)),
            ),
          ),
          ListTile(
            onTap: () {
              String? pageName = ModalRoute.of(context)?.settings.name;
              if (pageName != 'ConnectSshServer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: 'shell'),
                    builder: (context) => TerminalPage(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            leading: const Icon(Icons.insert_comment, color: Color(0xFF0A1730)),
            title: const Text(
              "shell",
              style: TextStyle(color: Color(0xFF0A1730)),
            ),
          ),
          ShowAlertSettings(),
        ],
      ),
    );
  }
}
