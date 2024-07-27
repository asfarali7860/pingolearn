// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:pingolearn/utils/colors.dart';


class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      context.goNamed(AppRoute.loginScreen.name);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhite,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/icons/pingo.png')),
          ],
        ),
      ),
    );
  }
}
