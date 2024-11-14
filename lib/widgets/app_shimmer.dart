import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Lottie.asset("assets/animations/shimmer.json", fit: BoxFit.cover),
    );
  }
}
