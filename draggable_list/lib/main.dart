import 'package:draggable_list/example.dart';
import 'package:draggable_list/hel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HorizontalExample();
  }
}
