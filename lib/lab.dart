import 'package:flutter/material.dart';

class Lab extends StatelessWidget {
  const Lab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab"),
      ),
      body: Column(
        children: [
          Text("asd"),
          Align(
            child: Row(
              children: [
                Icon(Icons.device_hub_sharp),
                Text("asd")
              ],
            ),
          )
        ],
      ),
    );
  }
}
