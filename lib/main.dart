import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/responsive/mobile_screen_layout.dart';
import 'package:flutter_application/responsive/responsive_screen_layout.dart';
import 'package:flutter_application/responsive/web_screen_layout.dart';
import 'package:flutter_application/screens/login_screen_layout.dart';
import 'package:flutter_application/screens/signup_screen_layout.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAtrpJcW87gucMxeHZqWUm9KFEO8ddvql4",
        appId: "1:211807649198:web:4a1456621815f4a7565c3f",
        messagingSenderId: "211807649198",
        projectId: "flutter--application",
        storageBucket: "flutter--application.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        }),
      ),
    );
  }
}
