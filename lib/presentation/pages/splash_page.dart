import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magang_app/common/constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    String? token = await storage.read(key: 'token');
    String? role = await storage.read(key: 'role');
    if (token != null && role == 'Mahasiswa') {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/dashboard'),
      );
    } else if (token != null && role == 'Pembimbing') {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/dashboard-pembimbing'),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/login-mahasiswa'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_tedc.png',
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    "Aplikasi Praktik Kerja Industri",
                    style: kBold.copyWith(
                      color: backgroundColor,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Politeknik TEDC Bandung",
                    style: kBold.copyWith(
                      color: backgroundColor,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
