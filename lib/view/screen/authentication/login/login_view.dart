import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/components/custom_button.dart';
import 'package:pingolearn/view/components/custom_text_field.dart';
import 'package:pingolearn/view/components/validator.dart';
import 'package:pingolearn/view/screen/authentication/register/signup_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
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
                gapH12,
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
                  text: "Login", 
                  isBusy: context.watch<SignUpViewModel>().isLoading,
                  width: MediaQuery.of(context).size.width * 0.6,
                  onTap: () async {
                    await context.read<SignUpViewModel>().signInWithEmail(_emailController.text, _passwordController.text, context);
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
      ),
    );
  }
}