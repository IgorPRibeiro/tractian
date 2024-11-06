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
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) =>  HomePage(),
        AssetsPage.routeName: (context) => const AssetsPage(),
      },
    );
  }
}
