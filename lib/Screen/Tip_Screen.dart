import 'package:flutter/material.dart';

class TipScreen extends StatelessWidget
{
  const TipScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      appBar: AppBar(title: const Text("Today Tip")),
      body: const Center(child:Text("This is Tip Screen")),
    );
  }
}