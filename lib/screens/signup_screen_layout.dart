import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/resources/auth_method.dart';
import 'package:flutter_application/responsive/mobile_screen_layout.dart';
import 'package:flutter_application/responsive/responsive_screen_layout.dart';
import 'package:flutter_application/responsive/web_screen_layout.dart';
import 'package:flutter_application/screens/login_screen_layout.dart';

import 'package:flutter_application/utils/colors.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout()),
      ));
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
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

                    //circular widget to accept and show our selected file
                    Stack(children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://www.google.com.tr/imgres?imgurl=https%3A%2F%2Fwww.seblod.com%2Fimages%2Fmedias%2F62057%2F_thumb2%2F2205256774854474505_medium.jpg&tbnid=LcF8BP6P40JNCM&vet=12ahUKEwjFlICMk5r_AhWZkqQKHWoIAdEQMygAegUIARCqAQ..i&imgrefurl=https%3A%2F%2Fwww.seblod.com%2Fcommunity%2Fforums%2Fforms-content-types%2Fdefault-image-upload&docid=H2oMTs7rjZRRWM&w=247&h=247&q=default%20upload%20image&ved=2ahUKEwjFlICMk5r_AhWZkqQKHWoIAdEQMygAegUIARCqAQ'),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 64),

                    // text field input for username
                    TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController,
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
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : const Text('Sign up '),
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
