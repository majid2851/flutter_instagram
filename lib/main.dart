import 'package:flutter/material.dart';

import 'widget/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home:  Test(),

    );
  }
}

