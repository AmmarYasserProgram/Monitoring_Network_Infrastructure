import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_futter_m_3/system_infrastructure/terminalPage.dart';
import 'package:provider/provider.dart';

import 'device_model.dart';
import 'device_provider.dart';
import 'package:project_futter_m_3/system_infrastructure/widget_my/sharing_drawer.dart';

class ScanningDevices extends StatefulWidget {
  const ScanningDevices({super.key});

  @override
  State<ScanningDevices> createState() => _ScanningDevicesState();
}

class _ScanningDevicesState extends State<ScanningDevices> {
  final TextEditingController networkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isScanning = false;

  // ------------------------------------------------
  // دالة الفحص - حالياً تستخدم بيانات وهمية
  // ------------------------------------------------

  void scanNetwork() async {
    if (!_formKey.currentState!.validate()) return;

    String network = networkController.text.trim();
    await context.read<DeviceProvider>().scan(network);
  }

  // ------------------------------------------------
  // صورة الجهاز حسب النوع
  // ------------------------------------------------
  String getDeviceImage(String type) {
    if (type == "windows") {
      return "https://upload.wikimedia.org/wikipedia/commons/5/5f/Windows_logo_-_2012.svg";
    }
    if (type == "android") {
      return "https://upload.wikimedia.org/wikipedia/commons/d/d7/Android_robot.svg";
    }
    if (type == "router") {
      return "https://cdn-icons-png.flaticon.com/512/3203/3203071.png";
    }
    return "https://cdn-icons-png.flaticon.com/512/2906/2906274.png";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SharingDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Scanning Devices",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0A1730),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: networkController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9./]')
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: "Network Address",
                        hintText: "192.168.1.0/24",
                        prefixIcon: const Icon(Icons.lan),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.trim().isEmpty) {
                          networkController.text="";
                          return "ادخل عنوان ip address";
                        }
                        final octets = value.split('.');
                        if (octets.length != 4){
                          return "This is false ip address";
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: context.watch<DeviceProvider>().isActive ? null : scanNetwork,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730))
                      ),
                      child: context.watch<DeviceProvider>().isActive
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.search , color: Colors.red,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Devices Found: ${context.watch<DeviceProvider>().data?.online ?? 0}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: context.watch<DeviceProvider>().data == null
                    ? const Center(
                        child: Text(
                          "No devices found",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: context.watch<DeviceProvider>().data!.data.length,
                        itemBuilder: (context, index) {
                          final device = context.watch<DeviceProvider>().data!.data[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: ListTile(
                                leading: Icon(Icons.devices),
                                title: Text(
                                  device.ip,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Column(
                                  children: [
                                    // Icon(
                                    //   Icons.circle,
                                    //   size: 12,
                                    //   color: device.state
                                    //       ? Colors.blueAccent
                                    //       : Colors.green,
                                    // ),
                                    // const SizedBox(height: 5),
                                    
                                    FilledButton(
                                      onPressed: (){
                                        if(device.state){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                settings: RouteSettings(name: 'shell'),
                                                  builder: (context) => TerminalPage(),
                                              )
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(device.state ? Colors.green : Colors.red),
                                      ),
                                      child: Text("shell",),

                                    )
                                    // Text(
                                    //   device.state ? "Online" : "Offline",
                                    //   style: TextStyle(
                                    //     color: device.state
                                    //         ? Colors.green
                                    //         : Colors.red,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
