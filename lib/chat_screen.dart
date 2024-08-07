import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone/camera_preview.dart';
import 'package:whatsapp_clone/constants.dart';

import 'settings.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardOpen = bottomInsets != 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + ' (YOU)'),
        actions: [
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
                    const PopupMenuItem(
                      child: Text('Logout'),
                      value: 3,
                    ),
                  ]),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 305,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDarkMode
                                ? Colors.transparent
                                : Color(0xFFf6f5f3),
                            hintText: 'Message',
                            contentPadding: EdgeInsets.only(top: 10),
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                size: 35,
                              ),
                            ),
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: isKeyboardOpen
                                    ? IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.attach_file,
                                          size: 30,
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.attach_file,
                                              size: 30,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  (context),
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CameraScreen()));
                                            },
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 2, 10),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          isKeyboardOpen ? Icons.send : Icons.mic,
                          color: isDarkMode ? Colors.black : Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor: isDarkMode
                              ? const MaterialStatePropertyAll(titleColor)
                              : const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 56, 192, 60)),
                          iconSize: isKeyboardOpen
                              ? MaterialStatePropertyAll(25)
                              : MaterialStatePropertyAll(30),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
