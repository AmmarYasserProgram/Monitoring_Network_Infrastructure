import 'package:flutter/material.dart';
import 'package:project_futter_m_3/system_infrastructure/widget_my/sharing_drawer.dart';

class TerminalPage extends StatefulWidget {
  const TerminalPage({super.key});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  final TextEditingController _commandController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> terminalLines = [
    "#"
  ];

  void sendCommand() {
    String command = _commandController.text.trim();
    if (command.isEmpty) {
      return;
    }
    setState(() {
      terminalLines.add("#$command");
      // مكانك هنا لإضافة تنفيذ الأمر لاحقاً
      terminalLines.add(" $command");
      terminalLines.add("");
    });
    _commandController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void clearTerminal() {
    setState(() {
      terminalLines = ["#"];
    });
  }

  @override
  void dispose() {
    _commandController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      drawer: SharingDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF0A1730),
        title: const Row(
          children: [
            Icon(Icons.terminal, color: Colors.white),
            SizedBox(width: 10),
            Text("Terminal", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: clearTerminal,
          ),
        ],
      ),
      body: Column(
        children: [
          // Device Information
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "shell",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Terminal
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xff101010),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: terminalLines.length,
                itemBuilder: (context, index) {
                  String line = terminalLines[index];
                  bool isCommand = line.startsWith("#");
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      line,
                      style: TextStyle(
                        fontFamily: "Courier",
                        fontSize: 14,
                        color: isCommand ? Colors.greenAccent : Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Command Input
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            color: Colors.white,
            child: Row(
              children: [
                const Text(
                  ">",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _commandController,
                    onSubmitted: (_) {
                      sendCommand();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter command...",
                      filled: true,
                      fillColor: const Color(0xfff2f2f2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ElevatedButton(
                    onPressed: sendCommand,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
