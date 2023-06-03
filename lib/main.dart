import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/pages/splash.dart';

void main() async {
  //initiaise the db
  await Hive.initFlutter();

  //create db
    final table = Hive.openBox("TasksTable");

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme:ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Splash(),
      // theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
