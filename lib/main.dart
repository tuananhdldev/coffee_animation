import 'package:coffee_animation/coffee_challenge/coffee_app.dart';
import 'package:coffee_animation/test_page_view.dart';
import 'package:flutter/material.dart';

import 'bank_challenge/bank_challenge_app.dart';
import 'home.dart';
import 'test_animation.dart';

void main() {
  runApp(const BankChallengeApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
