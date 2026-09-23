import 'package:flutter/material.dart';
import 'package:project_futter_m_3/device_scanner/device_provider.dart';

import 'package:project_futter_m_3/port_scanner/port_provider.dart';

import 'package:provider/provider.dart';

import 'login_system.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PortProvider>(create: (_)=> PortProvider()),
        ChangeNotifierProvider<DeviceProvider>(create: (_)=> DeviceProvider()),
      ],
      child: MaterialApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
        title: "Network Monitoring",
      ),
    );
  }
}