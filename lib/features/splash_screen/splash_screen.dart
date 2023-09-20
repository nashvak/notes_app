import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:notes_app/features/Todo_list/screens/bottomNavigation/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    navigation();
    super.initState();
  }

  void navigation() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still in the tree
        // Navigator.pushReplacementNamed(context, 'bottom');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('images/splash.json',
            width: 200, height: 200, fit: BoxFit.cover),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it's still active
    super.dispose();
  }
}
