import 'package:flutter/material.dart';
import 'package:flutter_application/resources/auth_method.dart';
import 'package:flutter_application/responsive/mobile_screen_layout.dart';
import 'package:flutter_application/responsive/responsive_screen_layout.dart';
import 'package:flutter_application/responsive/web_screen_layout.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/screens/signup_screen_layout.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application/screens/signup_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "succcess") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
      //
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Container(), flex: 2),

                    SvgPicture.asset(
                      'assets/blue-removebg-preview.svg',
                      color: primaryColor,
                      height: 64,
                    ),

                    const SizedBox(height: 64),
                    TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your Bio',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    InkWell(
                      onTap: loginUser,
                      child: Container(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text('Log in '),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(child: Container(), flex: 2),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          child: const Text("Don't have an account"),
                          padding: const EdgeInsets.symmetric(vertical: 8)),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            child: const Text(
                              "Sign up",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8)),
                      ),
                    ])

                    //  text field input for email

                    // text field input for password

                    //button login

                    // Transitioning to siging up
                  ],
                ))));
  }
}
