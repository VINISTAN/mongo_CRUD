import 'package:flutter/material.dart';
import 'package:flutterprojects/Screens/insert.dart';
import 'package:flutterprojects/Database/mongodb_connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "FlutMongo",
      home: InsertData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
