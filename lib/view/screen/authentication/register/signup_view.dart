import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/data/remote/users/user_model.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/components/custom_button.dart';
import 'package:pingolearn/view/components/custom_text_field.dart';
import 'package:pingolearn/view/components/validator.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
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
                CommonTextField(
                  hintText: 'Name', 
                  controller: _nameController, 
                  keyboardType: TextInputType.name, 
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your full name';
                    }
                    return null;
                  },
                ),
                gapH8,
                CommonTextField(
                  hintText: 'Email', 
                  controller: _emailController, 
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your email ';
                    } else if (value.isValidEmail() == false) {
                      return 'invalid email';
                    } else if (value.isValidEmail() == true) {
                      return null;
                    }
                    return null;
                  },
                ),
                gapH8,
                CommonTextField(
                  hintText: 'Password', 
                  controller: _passwordController, 
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                    return null;
                  },
                ),
              ],
            ),
            Column(
              children: [
                gapH60,
                CustomButton(
                  text: "Sign Up", 
                  width: MediaQuery.of(context).size.width * 0.6,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      UserModel? user = await context.read<SignUpViewModel>().signUpWithEmail(_emailController.text, _passwordController.text, _nameController.text);
                      log(user.toString());
                      if (user != null) {
                        context.pushReplacementNamed(AppRoute.loginScreen.name);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up failed')));
                      }
                    }
                  },
                ),
                gapH10,
                InkWell(
                  onTap: () {
                    context.pushReplacementNamed(AppRoute.loginScreen.name);
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Color(0xFF5D5D5D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
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
      ),
    );
  }
}