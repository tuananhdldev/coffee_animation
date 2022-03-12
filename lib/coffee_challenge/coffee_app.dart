import 'package:coffee_animation/coffee_challenge/ui/coffee_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeChallengeApp extends StatelessWidget {
  const CoffeeChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coffee App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.brown,
          primaryColor: Colors.white,
          textTheme: TextTheme(
            headline5: GoogleFonts.poppins(
                color: Colors.brown[700],
                fontWeight: FontWeight.w600,
                fontSize: 28,
                height: 1.1),
            headline2:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 64),
            headline6: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 22, height: 1.1),
            subtitle1: GoogleFonts.poppins(
                color: Colors.brown[400],
                fontWeight: FontWeight.w300,
                fontSize: 18),
          )),
      home: const CoffeeHomePage(),
    );
  }
}
