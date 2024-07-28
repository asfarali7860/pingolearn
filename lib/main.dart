import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_viewmodel.dart';
import 'package:pingolearn/view/screen/home/homescreen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pingolearn/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
      ChangeNotifierProvider(create: (_) => SignUpViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: router,
    );
  }
}