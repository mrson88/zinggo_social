import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:zinggo_social/modules/chat_screen/helper/helper_function.dart';
import 'package:zinggo_social/modules/chat_screen/screens/home_page.dart';
import 'package:zinggo_social/modules/chat_screen/screens/profile_page.dart';
import 'package:zinggo_social/modules/chat_screen/screens/search_page.dart';
import 'package:zinggo_social/modules/chat_screen/services/auth_service.dart';
import 'package:zinggo_social/modules/chat_screen/services/database_service.dart';
import 'package:zinggo_social/modules/chat_screen/widgets/group_tile.dart';
import 'package:zinggo_social/modules/chat_screen/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  final user_google = FirebaseAuth.instance.currentUser!;
  final user_facebook = FacebookAuth.instance.permissions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          user_google.photoURL != null
              ? Container(
                  child: Image.network("${user_google.photoURL}"),
                  height: 100,
                  width: 100,
                )
              : Icon(
                  Icons.account_circle,
                  size: 200,
                  color: Colors.grey[700],
                ),
          const SizedBox(
            height: 15,
          ),
          Text(
            user_google.displayName.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            onTap: () {
              nextScreen(context, const HomeChatPage());
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.group),
            title: const Text(
              "Groups",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {},
            selected: true,
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: const Icon(Icons.person),
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            user_google.photoURL != null
                ? Image.network("${user_google.photoURL}")
                : Icon(
                    Icons.account_circle,
                    size: 200,
                    color: Colors.grey[700],
                  ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 17)),
                Text(user_google.displayName.toString(),
                    style: const TextStyle(fontSize: 17)),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email", style: TextStyle(fontSize: 17)),
                Text(user_google.email.toString(),
                    style: const TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
