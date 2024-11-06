import 'package:flutter/material.dart';
import 'package:tractian/src/pages/assets_page.dart';
import 'package:tractian/src/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        AssetsPage.routeName: (context) => const AssetsPage(),
      },
    );
  }
}
