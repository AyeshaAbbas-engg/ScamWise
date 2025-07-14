import 'package:flutter/material.dart';

class ReportScamPage extends StatelessWidget {
  const ReportScamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Scam'),
        backgroundColor: const Color.fromARGB(255, 24, 102, 116),
      ),
      body: const Center(
        child: Text('This is the scam reporting page (UI coming soon)'),
      ),
    );
  }
}
