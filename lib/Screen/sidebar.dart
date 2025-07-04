import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 10, 22, 89)),
            child: Text(
              "ScamWise here :)",
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text("Alerts")),
          ListTile(leading: Icon(Icons.warning), title: Text("Alerts")),
          ListTile(
            leading: Icon(Icons.tips_and_updates),
            title: Text('Safety Tips'),
          ),
        ],
      ),
    );
  }
}
