import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/login.dart';

import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: 'Ashhad Ahmed');
  final emailController =
      TextEditingController(text: 'ashhadahmed72@gmail.com');
  final passwordController = TextEditingController(text: 'ashhad1779');
  final phoneNumberController = TextEditingController(text: '03343580882');

  bool obscureText = true;
  String AccountType = 'User';

  var AccountTypes = [
    'User',
    'Business',
    'Creator',
  ];

  bool isLoading = false; // Moved isLoading here

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: GoogleFonts.poppins(
            color: isDarkMode ? titleColor : Color.fromARGB(255, 4, 167, 9),
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      label: Text('Email'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
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
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        label: Text('Select Account Type'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      isEmpty: AccountType == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          dropdownDecoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          buttonHeight: 30,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: AccountTypes.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              AccountType = newValue!;
                              state.didChange(newValue);
                            });
                          },
                          value: AccountType,
                        ),
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a user type';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        sp.setString('name', nameController.text);
                        sp.setString('email', emailController.text);
                        sp.setString('phoneNumber', phoneNumberController.text);
                        sp.setString('password', passwordController.text);
                        sp.setString('AccountType', AccountType);

                        if (_formKey.currentState!.validate()) {
                          // sp.setBool('isLogin', true);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(
                                'Processing Data',
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white),
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
                                    builder: (context) => const Login()));
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        fixedSize:
                            const MaterialStatePropertyAll(Size(500, 60)),
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
