// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {

  List<Map<String, dynamic>> tileNames = [
    {
      "icon": Icons.notifications,
      "title": "Notifications",
      "desc":  "Set up notification"
    },
    {
      "icon": Icons.delete_rounded,
      "title": "Trash",
      "desc":  "Check out trash"
    },
    {
      "icon": Icons.settings,
      "title": "Settings",
      "desc":  "Customize your settings"
    },
    {
      "icon": Icons.question_mark_outlined,
      "title": "FAQs",
      "desc":  "Have any questions?"
    },
    {
      "icon": Icons.logout,
      "title": "Log out",
      "desc":  "Want to leave"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "MyNews",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: kWhite,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gapH32,
            const CircleAvatar(
              radius: 35,
              child: Icon(
                Icons.person,
                size: 35,
              ),
            ),
            gapH8,
            Text(
              context.read<SignUpViewModel>().userDetails.name ?? '',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: kBlack,
                fontWeight: FontWeight.bold
              ),
            ),
            gapH48,
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: tileNames.length,
                separatorBuilder: (context, index) {
                  return gapH12;
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      if(index == 4){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.remove('uid');
                        context.read<SignUpViewModel>().signOut(context);
                      }
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          gapW10,
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: kBlack, width: 2)
                            ),
                            child: Icon(tileNames[index]['icon']),
                          ),
                          gapW16,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tileNames[index]['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: kBlack,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                tileNames[index]['desc'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kBlack,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}