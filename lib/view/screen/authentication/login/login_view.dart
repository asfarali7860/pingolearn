import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/components/custom_button.dart';
import 'package:pingolearn/view/components/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              gapW24,
              Text(
                "MyNews",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: kBlue,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Column(
            children: [
              CommonTextField(hintText: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress,),
              gapH12,
              CommonTextField(hintText: 'Password', controller: _passwordController, isPassword: true,),
            ],
          ),
          Column(
            children: [
              gapH60,
              CustomButton(
                text: "Login", 
                width: MediaQuery.of(context).size.width * 0.6,
                onTap: (){
                  context.pushReplacementNamed(AppRoute.homeScreen.name);
                },
              ),
              gapH10,
              InkWell(
                onTap: () {
                  context.pushReplacementNamed(AppRoute.signupScreen.name);
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'New Here? ',
                        style: TextStyle(
                          color: Color(0xFF5D5D5D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}