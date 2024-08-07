import 'package:flutter/material.dart';

class WhatsappUI extends StatefulWidget {
  const WhatsappUI({super.key});

  @override
  State<WhatsappUI> createState() => _WhatsappUIState();
}

class _WhatsappUIState extends State<WhatsappUI> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          bottom:
              const TabBar(labelPadding: EdgeInsets.only(bottom: 10), tabs: [
            Text('Chats'),
            Text('Status'),
            Text('Calls'),
          ]),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            PopupMenuButton(
                itemBuilder: (context) => const [
                      PopupMenuItem(
                        child: Text('New Group'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Settings'),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text('Linked Devices'),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text('Logout'),
                        value: 3,
                      ),
                    ]),
          ],
        ),
        body: TabBarView(
          children: [
            //chats tab
            ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: CircleAvatar(
                      minRadius: 20,
                      maxRadius: 30,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/81470672?v=4'),
                    ),
                    title: Text('Ashhad Ahmed'),
                    subtitle: Text('Where is my cat?'),
                    trailing: Text('3.40 PM'),
                  );
                }),

            //status tab
            ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                        child: Text(
                          'New Updates',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                                        backgroundImage: NetworkImage(
                                            'https://avatars.githubusercontent.com/u/81470672?v=4'),
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
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
                        child: Text(
                          'Viewed Updates',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return const ListTile(
                                leading: CircleAvatar(
                                  minRadius: 20,
                                  maxRadius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://avatars.githubusercontent.com/u/81470672?v=4'),
                                ),
                                title: Text('Ashhad Ahmed'),
                                subtitle: Text('10m ago'),
                              );
                            })),
                      ),
                    ],
                  );
                }
              },
            ),

            //calls tab
            ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      minRadius: 20,
                      maxRadius: 30,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/81470672?v=4'),
                    ),
                    title: const Text('Ashhad Ahmed'),
                    subtitle: Text(index % 2 == 0
                        ? 'Missed Phone Call 3.40 PM'
                        : 'Missed Video Call 3.40 PM'),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                            index % 2 == 0 ? Icons.phone : Icons.video_call)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
