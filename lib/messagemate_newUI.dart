import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/camera_preview.dart';
import 'package:whatsapp_clone/constants.dart';
import 'package:whatsapp_clone/settings.dart';
import 'package:whatsapp_clone/signup.dart';

import 'chat_screen.dart';

class WhatsappNewUI extends StatefulWidget {
  const WhatsappNewUI({super.key});

  @override
  State<WhatsappNewUI> createState() => _WhatsappNewUIState();
}

class _WhatsappNewUIState extends State<WhatsappNewUI> {
  String name = '';
  String email = '';
  String phoneNumber = '';
  int _selectedIndex = 0;

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
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return DefaultTabController(
      initialIndex: _selectedIndex,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'MessageMate',
            style: GoogleFonts.poppins(
                color: isDarkMode ? titleColor : Color.fromARGB(255, 4, 167, 9),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CameraScreen()));
                },
                icon: const Icon(Icons.camera_alt_outlined)),
            PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('New Group'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: const Text('Settings'),
                        value: 2,
                        onTap: () {
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) => const Settings()));
                        },
                      ),
                      const PopupMenuItem(
                        child: Text('Linked Devices'),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text('Logout'),
                        value: 3,
                        onTap: () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();

                          sp.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                      ),
                    ]),
          ],
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                splashColor: Colors.black,
                backgroundColor: Colors.green,
                onPressed: () {},
                child: Icon(
                  Icons.library_add_rounded,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              )
            : null,
        body: TabBarView(
          children: [
            // Chats tab
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: SearchBar(
                      leading: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
                      ),
                      hintText: 'Search...',
                      hintStyle: const MaterialStatePropertyAll(TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      )),
                      backgroundColor: isDarkMode
                          ? const MaterialStatePropertyAll(Colors.transparent)
                          : const MaterialStatePropertyAll(
                              const Color(0xFFf6f5f3),
                            ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChatScreen(title: name)));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            minRadius: 20,
                            maxRadius: 30,
                            backgroundImage:
                                AssetImage('assets/images/sample_image.jpeg'),
                          ),
                          title: Text(name + ' (YOU)'),
                          subtitle: Text(phoneNumber),
                          trailing: Text('3.40 PM'),
                        ),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),

            //status tab
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 20, top: 10),
                        child: Text(
                          'New Updates',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10, // Number of status updates
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.green, width: 3),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: const CircleAvatar(
                                        minRadius: 20,
                                        maxRadius: 30,
                                        backgroundImage: AssetImage(
                                            'assets/images/sample_image.jpeg'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  const Text('Ashhad Ahmed'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        child: Text(
                          'Viewed Updates',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.grey, width: 3),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const CircleAvatar(
                                      minRadius: 20,
                                      maxRadius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/sample_image.jpeg'),
                                    ),
                                  ),
                                ),
                                title: const Text('Ashhad Ahmed'),
                                subtitle: const Text('10m ago'),
                              );
                            })),
                      ),
                    ],
                  );
                }
              },
            ),
            //communities tab
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 350,
                  height: 80,
                  child: IconButton(
                      onPressed: () {},
                      icon: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isDarkMode
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade200,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.group_add_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'New Community',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                const Divider(
                  thickness: 4,
                ),
                Container(
                  height: 370,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          leading: CircleAvatar(
                            minRadius: 20,
                            maxRadius: 30,
                            backgroundImage:
                                AssetImage('assets/images/sample_image.jpeg'),
                          ),
                          title: Text('Ashhad Ahmed'),
                          subtitle: Text('Where is my cat?'),
                          trailing: Text('3.40 PM'),
                        );
                      }),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'View all',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    )),
              ],
            ),

            //calls tab
            ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      minRadius: 20,
                      maxRadius: 30,
                      backgroundImage:
                          AssetImage('assets/images/sample_image.jpeg'),
                    ),
                    title: const Text('Ashhad Ahmed'),
                    subtitle: Text.rich(
                      TextSpan(
                          text: index % 2 == 0
                              ? 'Missed Phone Call '
                              : 'Missed Video Call ',
                          children: [
                            TextSpan(
                                text: '3.40 PM',
                                style: TextStyle(color: Colors.grey))
                          ]),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                            index % 2 == 0 ? Icons.phone : Icons.video_call)),
                  );
                }),
          ],
        ),
        bottomNavigationBar: TabBar(
          onTap: _onItemTapped,
          unselectedLabelColor: Colors.green,
          labelColor: isDarkMode ? Colors.white : Colors.black,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(icon: Icon(Icons.chat_outlined), text: 'Chats'),
            Tab(icon: Icon(Icons.update_outlined), text: 'Updates'),
            Tab(icon: Icon(Icons.groups_3_outlined), text: 'Communities'),
            Tab(icon: Icon(Icons.call_outlined), text: 'Calls'),
          ],
        ),
      ),
    );
  }
}
