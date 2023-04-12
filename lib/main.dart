import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Palette.lightsOutModeAppTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


