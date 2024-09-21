import 'dart:async';

import 'package:auctionapp/Controllers/database_Controller.dart';
import 'package:auctionapp/Views/home_Screen.dart';
import 'package:flutter/material.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    Database_Controller.database_controller.CreateDatabase();
    Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('Welcome to Auction Application'),
      ),
    );
  }
}
