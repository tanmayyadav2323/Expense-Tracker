import 'package:flutter/material.dart';
import 'package:personal_expenses/models/months.dart';
import 'package:personal_expenses/models/user_detail.dart';
import 'package:personal_expenses/screens/graph.dart';
import 'package:personal_expenses/screens/tarnsaction_screen.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => UserDetail(),
        child: HomeScreen(),
      ),
    );
  }
}
