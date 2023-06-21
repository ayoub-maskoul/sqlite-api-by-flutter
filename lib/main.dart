import 'package:flutter/material.dart';
import 'package:test/screens/home.dart';
void main() {
  runApp( MyApp());
}


class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Myhome()
  );}
}
