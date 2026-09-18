import 'package:flutter/material.dart';
class ScanningDevices extends StatefulWidget {
  const ScanningDevices({super.key});

  @override
  State<ScanningDevices> createState() => _ScanningDevicesState();
}
class _ScanningDevicesState extends State<ScanningDevices> {
  final TextEditingController networkController =TextEditingController();
  bool isScanning = false;

// بيانات وهمية مؤقتة
  List<Map<String, dynamic>> devices = [];

// ------------------------------------------------
// دالة الفحص - حالياً تستخدم بيانات وهمية
// ------------------------------------------------

  void scanNetwork() async {
    String network = networkController.text.trim();
    if (network.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter network address first"),
        ),
      );
      return;
    }setState(() {
      isScanning = true;
      devices = [];
    });
// محاكاة انتظار السيرفر
  await Future.delayed(const Duration(seconds: 2));
// البيانات التي نتخيل أن Flask رجعها
  List<Map<String, dynamic>> fakeResponse = [
    {"ip": "192.168.1.1","hostname": "Router","type": "router","status": "online",}
    ,{"ip": "192.168.1.10","hostname": "ISE-Server","type": "linux","status": "online",}
    ,{"ip": "192.168.1.20","hostname": "PC-Manager","type": "windows","status": "online",}
    ,{"ip": "192.168.1.21","hostname": "PC-Employee","type": "windows","status": "online",}
    ,{"ip": "192.168.1.30","hostname": "Android-Phone","type": "android","status": "online",}
    ,];
  setState(() {
    devices = fakeResponse;
    isScanning = false;
  });
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
// ------------------------------------------------
// الواجهة
// ------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanning Devices"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
// ----------------------------------------
// Network Address + Scan Button
// ----------------------------------------
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: networkController,
                    decoration: InputDecoration(
                      labelText: "Network Address",
                      hintText: "192.168.1.0/24",
                      prefixIcon: const Icon(Icons.lan),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),)
                      ,),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: isScanning? null:
                    scanNetwork,
                    child: isScanning? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    ): const Icon(Icons.search),),),],),const SizedBox(height: 20),
// ----------------------------------------
// عدد الأجهزة
// ----------------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Devices Found: ${devices.length}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,),
              ),
            ),const SizedBox(height: 10),

            Expanded(
              child: devices.isEmpty? const Center(
                child: Text("No devices found",
                  style: TextStyle(fontSize: 17,color: Colors.grey,),
                ),
              ): ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12,),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            padding:const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius:BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              getDeviceImage(
                                device["type"],
                              ),
                              fit: BoxFit.contain,
                              errorBuilder:(context, error, stack) {
                                return const Icon(Icons.devices,size: 40,);
                                },
                            ),
                          ),const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(
                                  device["hostname"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:FontWeight.bold,),
                                ),
                                const SizedBox(height: 5),
                                Text("IP: ${device["ip"]}",
                                  style: const TextStyle(fontSize: 15,),
                                ),
                                const SizedBox(height: 5),
                                Text("Type: ${device["type"]}",
                                  style: const TextStyle(color: Colors.grey,),
                                ),
                              ],
                            ),
                          ),
// --------------------------------
// Online
// --------------------------------
                          Column(
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 12,
                                color: Colors.green,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                device["status"],
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}