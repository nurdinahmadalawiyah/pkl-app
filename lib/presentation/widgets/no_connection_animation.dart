import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:magang_app/common/constant.dart';

class NoConnectionAnimation extends StatelessWidget {
  const NoConnectionAnimation({
    Key? key, required this.message,
  }) : super(key: key);

  final String message;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/no-connection.json',
          width: 200,
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