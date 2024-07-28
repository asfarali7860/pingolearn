// ignore_for_file: avoid_print

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/screen/home/home_screen_view.dart';
import 'package:pingolearn/view/screen/profile/profile_view.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({
    super.key,
  });

  @override
  State<BottomNavigationView> createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
  int _selectedIndex = 0;
  final List<Widget> tabs = [
    const HomeScreenView(),
    const ProfileScreenView(),
  ];

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }


  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:  const IconThemeData(size: 35,),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() {
                isAlertSet = false;
              });
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                setState(() {
                  isAlertSet = true;
                });
              }
            },
            child: const Text('OK'))
      ],
    ),
  );
}
