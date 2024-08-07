// import 'package:flutter/material.dart';
// import 'package:whatsapp_clone/chat_screen.dart';

// class Contacts extends StatefulWidget {
//   const Contacts({super.key});

//   @override
//   State<Contacts> createState() => _ContactsState();
// }

// class _ContactsState extends State<Contacts> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ChatScreen()));
//                         },
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             minRadius: 20,
//                             maxRadius: 30,
//                             backgroundImage:
//                                 AssetImage('assets/images/sample_image.jpeg'),
//                           ),
//                           title: Text(name),
//                           subtitle: Text(phoneNumber),
//                           trailing: Text('3.40 PM'),
//                         ),
//                       );;
//   }
// }