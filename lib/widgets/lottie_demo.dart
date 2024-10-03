import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieDemo extends StatefulWidget {
  const LottieDemo({super.key});

  @override
  State<LottieDemo> createState() => _LottieDemoState();
}

class _LottieDemoState extends State<LottieDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          Container(
            height: 50,
            width: 50,
            color: Colors.blueAccent,
          )
        ],
      )
    );
  }
}

