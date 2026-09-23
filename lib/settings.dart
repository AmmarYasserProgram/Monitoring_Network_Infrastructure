import 'package:flutter/material.dart';

class ShowAlertSettings extends StatelessWidget {
  const ShowAlertSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        String? pageName = ModalRoute.of(context)?.settings.name;
        if (pageName != 'Settings') {
          showSettings(context);
        } else {
          Navigator.pop(context);
        }
      },
      leading: const Icon(Icons.settings, color: Color(0xFF0A1730)),
      title: const Text("Settings", style: TextStyle(color: Color(0xFF0A1730))),
    );
  }
}

void showSettings(BuildContext context) {
  bool notifications = true;
  bool darkMode = false;
  bool autoRefresh = true;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.settings, color: Color(0xFF0A1730)),
                SizedBox(width: 10),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Color(0xFF0A1730),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(
                        Icons.notifications,
                        color: Color(0xFF0A1730),
                      ),
                      title: const Text("Notifications"),
                      subtitle: const Text("Receive network alerts"),
                      value: notifications,
                      onChanged: (value) {
                        setState(() {
                          notifications = value;
                        });
                      },
                    ),
                    const Divider(),
                    // Dark Mode
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(
                        Icons.dark_mode,
                        color: Color(0xFF0A1730),
                      ),
                      title: const Text("Dark Mode"),
                      subtitle: const Text("Change application appearance"),
                      value: darkMode,
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    ),
                    const Divider(),
                    // Auto Refresh
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      secondary: const Icon(
                        Icons.refresh,
                        color: Color(0xFF0A1730),
                      ),
                      title: const Text("Auto Refresh"),
                      subtitle: const Text("Automatically update network data"),
                      value: autoRefresh,
                      onChanged: (value) {
                        setState(() {
                          autoRefresh = value;
                        });
                      },
                    ),
                    const Divider(),
                    // Refresh Interval
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.timer,
                        color: Color(0xFF0A1730),
                      ),
                      title: const Text("Refresh Interval"),
                      subtitle: const Text("Every 5 seconds"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.security,
                        color: Color(0xFF0A1730),
                      ),
                      title: const Text("Security"),
                      subtitle: const Text("Network security settings"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    },
  );
}
