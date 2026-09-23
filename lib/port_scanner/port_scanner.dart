import 'package:flutter/material.dart';
import 'package:project_futter_m_3/port_scanner/port_provider.dart';
import 'package:project_futter_m_3/system_infrastructure/widget_my/sharing_drawer.dart';
import 'package:provider/provider.dart';

class PortScannerPage extends StatefulWidget {
  const PortScannerPage({super.key});

  @override
  State<PortScannerPage> createState() => _PortScannerPageState();
}

class _PortScannerPageState extends State<PortScannerPage> {
  final TextEditingController _ipController = TextEditingController();

  final TextEditingController _startPortController = TextEditingController();

  final TextEditingController _endPortController = TextEditingController();
  final _form_key = GlobalKey<FormState>();
  bool isScanning = false;

  double progress = 0;

  int openPorts = 0;
  int closedPorts = 0;

  // =========================================
  // Start Scan
  // =========================================

  Future startScan() async {

    var host = _ipController.text.toString().trim();
    var sr = int.parse(_startPortController.text.toString());
    var ed = int.parse(_endPortController.text.toString());
    await context.read<PortProvider>().scan(host: host, sr: sr, ed: ed);

    // =====================================
    // أنت ستضع كود فحص المنافذ هنا
    // =====================================
  }

  // =========================================
  // Stop Scan
  // =========================================

  void stopScan() {
    setState(() {
      isScanning = false;
    });
  }

  @override
  void dispose() {
    _ipController.dispose();
    _startPortController.dispose();
    _endPortController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xfff5f6fa),
      drawer: SharingDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1730),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Row(
          children: [
            Icon(Icons.manage_search, color: Colors.white),

            SizedBox(width: 8),

            Text("Port Scanner", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =====================================
              // Device Information
              // =====================================
              const Text(
                "Target Device",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Color(0xFF0A1730), blurRadius: 8),
                  ],
                ),
                child: Form(
                  key: _form_key,
                  child: Column(
                    children: [
                      // Device IP Address
                      TextFormField(
                        controller: _ipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.computer,
                            color: Color(0xFF0A1730),
                          ),
                          labelText: "Device IP Address",
                          hintText: "Example: 192.168.1.10",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الحقل مطلوب';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),
                      // Start Port
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _startPortController,

                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                labelText: "Start Port",
                                hintText: "1",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الحقل مطلوب';
                                }
                                return null;
                              },
                            ),
                          ),

                          const SizedBox(width: 12),
                          // End Port
                          Expanded(
                            child: TextFormField(
                              controller: _endPortController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "End Port",
                                hintText: "1024",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الحقل مطلوب';
                                }
                                else if(int.parse(value) < int.parse( _startPortController.text?? "0")){
                                  _endPortController.text = _startPortController.text;
                                  return 'ادخل قيمة >= ${_startPortController.text}';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // scanner btn
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (!_form_key.currentState!.validate())
                              return;
                            print('Start get');
                            await startScan();
                          },
                          icon: Icon(isScanning ? Icons.stop : Icons.play_arrow),

                          label: Text(
                            isScanning ? "Stop Scan" : "Start Scan",

                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: isScanning
                                ? Colors.red
                                : Color(0xFF0A1730),

                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Scan Progress
              if (context.watch<PortProvider>().isActive) ...[
                const Text(
                  "Scanning...",

                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
                LinearProgressIndicator(
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),


                const SizedBox(height: 20),
              ],

              // Statistics
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      "Open Ports",
                      "${context.watch<PortProvider>().data?.openPorts ?? 0}",
                      Icons.lock_open,
                      Colors.green,
                    ),
                  ),

                  const SizedBox(width: 12),
                  // closed port
                  Expanded(
                    child: _statCard(
                      "Closed Ports",
                      "${context.watch<PortProvider>().data?.closedPorts ?? 0}",
                      Icons.lock,
                      Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Results
              const Text(
                "Scan Results",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    if(context.watch<PortProvider>().data != null)
                      ...context.watch<PortProvider>().data!.data.map(
                              (itm) => _portResult(itm.port.toString(), "-",
                                  itm.status,
                                  (itm.status == 'open')? Colors.green : Colors.red
                              )
                      ).toList(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================
  // Statistics Card
  // =========================================

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(color: Color(0xFF0A1730), blurRadius: 8),
        ],
      ),

      child: Row(
        children: [
          Icon(icon, color: color, size: 30),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),

              Text(
                value,

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================
  // Port Result
  // =========================================

  Widget _portResult(
      String port,
      String service,
      String status,
      Color color
      ) {
    return ListTile(
      leading: Container(
        width: 45,
        height: 45,

        decoration: BoxDecoration(
          color: color.withOpacity(0.1),

          borderRadius: BorderRadius.circular(8),
        ),

        child: Icon(Icons.lan, color: color),
      ),

      title: Text(
        "Port $port",

        style: const TextStyle(fontWeight: FontWeight.bold),
      ),

      subtitle: Text(service),

      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

        decoration: BoxDecoration(
          color: color.withOpacity(0.1),

          borderRadius: BorderRadius.circular(20),
        ),

        child: Text(
          status,

          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
