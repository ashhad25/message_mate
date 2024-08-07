import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/signup.dart';
import 'package:whatsapp_clone/theme_Notifier.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String AccountType = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('name') ?? '';
    email = sp.getString('email') ?? '';
    phoneNumber = sp.getString('phoneNumber') ?? '';
    AccountType = sp.getString('AccountType') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/sample_image.jpeg'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(text: name + ' (YOU)'),
                    decoration: InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(text: email),
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(text: AccountType),
                    decoration: InputDecoration(
                      label: Text('Account Type'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(onPressed: () {}, child: const Text("Sign Out")),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setTheme(ThemeMode.light);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  child: const Text(
                    "Light Mode",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .setTheme(ThemeMode.dark);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  child: const Text(
                    "Dark Mode",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();

                    sp.clear();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
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
