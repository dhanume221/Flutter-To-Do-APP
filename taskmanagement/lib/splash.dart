// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:taskmanagement/mainpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNext();
  }

  void moveToNext() async {
    await Future.delayed(Duration(seconds: 2));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTasks(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/splashlogo1234567890.png",  
              width: 150,
              height: 150,
            ),
          ],
        ),
      ]),
    );
  }
}
