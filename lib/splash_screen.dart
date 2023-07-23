import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSkipped = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      _checkIfSkipped().then((isSkipped) {
        if (isSkipped) {
          _navigateToHome();
        }
      });
    });
  }

  Future<bool> _checkIfSkipped() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skipped') ?? false;
  }

  Future<void> _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipped', true);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _handleSkip() {
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Image/rm119batch4-adj-20-leavesframe.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'We show weather for you',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: _handleSkip,
                child: const Text('Skip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
