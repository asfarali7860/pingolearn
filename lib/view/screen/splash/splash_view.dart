// ignore_for_file: avoid_print, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    Future.delayed(const Duration(seconds: 2), () {
      if (uid != null) {
        context.read<SignUpViewModel>().fetchUserData(uid, context);
        context.pushReplacementNamed(AppRoute.bottomScreen.name);
      } else {
        context.pushReplacementNamed(AppRoute.loginScreen.name);
      }
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
