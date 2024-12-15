import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundCircles extends StatelessWidget {
  const BackgroundCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(7, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-7, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1.2),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 244, 167, 50),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
