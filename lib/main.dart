import 'package:flutter/material.dart';
import 'package:to_do_app/pages/splash.dart';

void  main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      // theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}