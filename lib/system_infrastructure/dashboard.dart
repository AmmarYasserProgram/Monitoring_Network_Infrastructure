import 'package:flutter/material.dart';
import 'package:project_futter_m_3/system_infrastructure/connect_ssh_server.dart';
import 'package:project_futter_m_3/system_infrastructure/scanning_devices.dart';
import 'package:project_futter_m_3/system_infrastructure/scanning_port_device.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF020817),

      appBar: AppBar(
        backgroundColor: Color(0xFF0A1730),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.network_check,
              size: 45,
              color: Colors.blue,
            ),
            SizedBox(width: 8,),
            const Text(
              "Network Monitor",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        // backgroundColor: const Color(0xFF071126),
        child: ListView(
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0A1730),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.network_check,
                    size: 45,
                    color: Colors.blue,
                  ),
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
              leading: const Icon(
                Icons.dashboard,
                color: Color(0xFF0A1730),
              ),
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Color(0xFF0A1730)),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.devices,
                color: Color(0xFF0A1730),
              ),
              title: const Text(
                "Devices",
                style: TextStyle(color:Color(0xFF0A1730)),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.warning,
                color: Color(0xFF0A1730),
              ),
              title: const Text(
                "Alerts",
                style: TextStyle(color: Color(0xFF0A1730)),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color(0xFF0A1730),
              ),
              title: const Text(
                "Settings",
                style: TextStyle(color: Color(0xFF0A1730)),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            // =========================
            // TOP STATISTICS
            // =========================
            LayoutBuilder(
              builder: (context, constraints) {

                int columns = constraints.maxWidth > 800 ? 5 : 2;

                return GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 2.3,

                  children: [

                    statCard(
                      title: "TOTAL DEVICES",
                      value: "43",
                      icon: Icons.devices,
                      iconColor: Colors.white,
                    ),

                    statCard(
                      title: "ONLINE",
                      value: "43",
                      icon: Icons.check_circle_outline,
                      iconColor: Colors.green,
                    ),

                    statCard(
                      title: "OFFLINE",
                      value: "0",
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                    ),

                    statCard(
                      title: "AVG LATENCY",
                      value: "17ms",
                      icon: Icons.bolt,
                      iconColor: Colors.amber,
                    ),

                    statCard(
                      title: "DATA CENTERS",
                      value: "3",
                      icon: Icons.storage,
                      iconColor: Colors.blue,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // =========================
            // SERVER + MEMORY + STORAGE
            // =========================
            LayoutBuilder(
              builder: (context, constraints) {

                bool desktop = constraints.maxWidth > 800;

                if (desktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // SERVER INFO
                      Expanded(
                        flex: 3,
                        child: serverInfo(),
                      ),

                      const SizedBox(width: 15),

                      // MEMORY
                      Expanded(
                        flex: 3,
                        child: usageCard(
                          title: "MEMORY",
                          percent: 59,
                          used: "4.6 / 7.8 GB",
                          color: Colors.deepPurple,
                          icon: Icons.memory,
                        ),
                      ),

                      const SizedBox(width: 15),

                      // STORAGE
                      Expanded(
                        flex: 3,
                        child: usageCard(
                          title: "STORAGE (/)",
                          percent: 63,
                          used: "15.1 / 24.4 GB",
                          color: Colors.orange,
                          icon: Icons.storage,
                        ),
                      ),
                    ],
                  );
                }

                // MOBILE
                return Column(
                  children: [

                    serverInfo(),

                    const SizedBox(height: 15),

                    usageCard(
                      title: "MEMORY",
                      percent: 59,
                      used: "4.6 / 7.8 GB",
                      color: Colors.deepPurple,
                      icon: Icons.memory,
                    ),

                    const SizedBox(height: 15),

                    usageCard(
                      title: "STORAGE (/)",
                      percent: 61,
                      used: "15.1 / 24.4 GB",
                      color: Colors.orange,
                      icon: Icons.storage,
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 130,
            ),
            Container(
              child: Wrap(
                spacing: 25,
                runSpacing: 15,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    onPressed: (){
                      String? pageName =  ModalRoute.of(context)?.settings.name;
                      print(pageName);
                    },
                    child: Text("Dashboard"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730)),
                    ),
                  ),
                  FilledButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            settings: RouteSettings(name: "ScanningDevices"),
                            builder: (context) => ScanningDevices())
                        );
                      },
                      child: Text("Scanning Devices"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730)),
                    ),
                  ),
                  FilledButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            settings: RouteSettings(name: 'ConnectSshServer'),
                            builder: (context)=> ConnectSshServer())
                        );
                      },
                      child: Text("SSH To Server"),
                      style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730)),),
                  ),
                  FilledButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          settings: RouteSettings(name: 'ScanningPortDevice'),
                          builder: (context) => ScanningPortDevice(),)
                        );
                      },
                      child: Text("Scaner Port Device"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFF0A1730)),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  // =====================================================
  // STAT CARD
  // =====================================================

  static Widget statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF050D20),

        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFF142344),
        ),

        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              Icon(
                icon,
                color: iconColor,
                size: 18,
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              color: iconColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Container(
            height: 1,
            color: const Color(0xFF18243D),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SERVER INFORMATION
  // =====================================================

  static Widget serverInfo() {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF050D20),

        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFF142344),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: const [

              Icon(
                Icons.settings_ethernet,
                size: 13,
                color: Colors.blue,
              ),

              SizedBox(width: 7),

              Text(
                "SERVER INFO",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          infoRow(
            "Hostname",
            "dashboard",
          ),

          infoRow(
            "OS",
            "Debian GNU/Linux 13 (trixie)",
          ),

          infoRow(
            "Kernel",
            "6.12.48+deb13-cloud-amd64",
          ),

          infoRow(
            "Uptime",
            "up 4 weeks, 1 day, 2 hours, 19 minutes",
          ),

          infoRow(
            "CPU Cores",
            "4 cores",
          ),

          infoRow(
            "IP Addresses",
            "192.168.203.151 (enp2s0)",
          ),
        ],
      ),
    );
  }

  // =====================================================
  // INFO ROW
  // =====================================================

  static Widget infoRow(
      String title,
      String value,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 9,
      ),

      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF17233A),
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 90,

            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // MEMORY / STORAGE CARD
  // =====================================================

  static Widget usageCard({
    required String title,
    required int percent,
    required String used,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: 285,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF050D20),

        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFF142344),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                icon,
                size: 13,
                color: color,
              ),

              const SizedBox(width: 7),

              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const Spacer(),

          Center(
            child: SizedBox(
              width: 120,
              height: 120,

              child: Stack(
                alignment: Alignment.center,

                children: [

                  SizedBox(
                    width: 120,
                    height: 120,

                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 10,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  SizedBox(
                    width: 120,
                    height: 120,

                    child: CircularProgressIndicator(
                      value: percent / 100,
                      strokeWidth: 10,
                      color: color,
                    ),
                  ),

                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      Text(
                        "$percent%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text(
                        "Used",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          Center(
            child: Text(
              used,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 5),
        ],
      ),
    );
  }
}