import 'package:coffee_animation/bank_challenge/ui/bank_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankChallengeApp extends StatelessWidget {
  const BankChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      home: const BankHomePage(),
    );
  }
}
