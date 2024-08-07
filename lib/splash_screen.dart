import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/constants.dart';
import 'package:whatsapp_clone/signup.dart';
import 'package:whatsapp_clone/messagemate_newUI.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;

    if (isLogin) {
      Timer(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WhatsappNewUI()));
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                      height: 150,
                      image:
                          AssetImage('assets/images/messagemate_splash.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'MessageMate',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      color: isDarkMode
                          ? titleColor
                          : const Color.fromARGB(255, 4, 167, 9),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Designed By Ashhad',
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'ashhadahmed72@gmail.com',
                    style: GoogleFonts.inter(color: Colors.grey),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
