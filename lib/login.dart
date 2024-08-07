import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/messagemate_newUI.dart';

import 'constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController(text: 'ashhad1779');
  final phoneNumberController = TextEditingController(text: '03343580882');

  bool obscureText = true;
  String AccountType = '';

  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    AccountType = sp.getString('AccountType') ?? '';
    setState(() {});
  }

  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign In',
          style: GoogleFonts.poppins(
            color: isDarkMode ? titleColor : Color.fromARGB(255, 4, 167, 9),
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    label: Text('Phone Number'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  obscureText: obscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText
                                ? obscureText = false
                                : obscureText = true;
                          });
                        },
                        icon: Icon(obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    label: Text('Password'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: AccountType),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  label: Text('Account Type'),
                  // hintText: AccountType,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  String phoneNumber = sp.getString('phoneNumber') ?? '';
                  String password = sp.getString('password') ?? '';

                  if (_formKey.currentState!.validate()) {
                    sp.setBool('isLogin', true);

                    if (phoneNumberController.text == phoneNumber &&
                        passwordController.text == password) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'Logging In...',
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.black : Colors.white),
                          ),
                          showCloseIcon: true,
                          closeIconColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                      );
                      Timer(const Duration(seconds: 1), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WhatsappNewUI()));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Incorrect Phone Number or Password!!',
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ],
                          ),
                          showCloseIcon: true,
                          closeIconColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  fixedSize: const MaterialStatePropertyAll(Size(500, 60)),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
