import 'package:flutter/material.dart';
import 'card.dart';

class Home_Page extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) toggletheme;

  const Home_Page({
    super.key,
    required this.isDarkMode,
    required this.toggletheme,
  });
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    return Scaffold(
      backgroundColor: isDarkMode
          ? Colors.black
          : const Color.fromARGB(255, 24, 102, 116),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: textColor),
        title: Text('ScamWise', style: TextStyle(color: textColor)),
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(backgroundColor: Colors.grey),
          ),
          Switch(
            value: isDarkMode,
            onChanged: toggletheme,
            activeColor: const Color.fromARGB(255, 24, 102, 116),
            inactiveThumbColor: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Today", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Infocard(
              title: "Today",
              amount: "\$45,678.90",
              subtitle: "+20% month over month",
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Infocard(title: "Title", amount: "\$45,678.90"),
            SizedBox(height: 12),
            Text("Yesterday", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Infocard(title: "Title", amount: "\$45,678.90"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.translate), label: ''),
        ],
      ),
    );
  }
}
