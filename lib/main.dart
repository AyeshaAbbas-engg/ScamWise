import 'package:flutter/material.dart';

import 'Screen/Home_Page.dart';

void main() {
  runApp(const ScamWise());
}

class ScamWise extends StatefulWidget {
  const ScamWise({super.key});

  @override
  State<ScamWise> createState() => _ScamWiseState();
}

class _ScamWiseState extends State<ScamWise> {
  bool isDarkmode = false;

  void toggletheme(bool value) {
    setState(() {
      isDarkmode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkmode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Home_Page(isDarkMode: isDarkmode, toggletheme: toggletheme),
    );
  }
}
