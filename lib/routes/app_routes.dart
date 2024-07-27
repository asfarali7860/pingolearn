import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingolearn/view/screen/authentication/login/login_view.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_view.dart';
import 'package:pingolearn/view/screen/home/home_screen_view.dart';
import 'package:pingolearn/view/screen/profile/profile_view.dart';
import 'package:pingolearn/view/screen/splash/splash_view.dart';

enum AppRoute {
  splashScreen,
  loginScreen,
  signupScreen,
  homeScreen,
  profileScreen
}

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: AppRoute.splashScreen.name,
      path: '/',
      builder: (context, state) => const SplashScreenView(),
    ),
    GoRoute(
      name: AppRoute.loginScreen.name,
      path: '/loginScreen',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: AppRoute.signupScreen.name,
      path: '/signupScreen',
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      name: AppRoute.homeScreen.name,
      path: '/homeScreen',
      builder: (context, state) => const HomeScreenView(),
    ),
    GoRoute(
      name: AppRoute.profileScreen.name,
      path: '/profileScreen',
      builder: (context, state) => const ProfileScreenView(),
    ),
  ],
  errorBuilder: (context, state) {
    return const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  },
);