import 'package:flutter/material.dart';

import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        hintColor: Colors.white,
        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) {
            return const Icon(
              Icons.arrow_back,
              color: Colors.white,
            );
          },
        ),
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
