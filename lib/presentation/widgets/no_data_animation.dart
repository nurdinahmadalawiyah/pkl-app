import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:magang_app/common/constant.dart';

class NoDataAnimation extends StatelessWidget {
  const NoDataAnimation({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/no-data.json',
          width: 250,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        Text(
          message,
          style: kMedium.copyWith(color: tertiaryColor, fontSize: 23),
        ),
      ],
    );
  }
}
