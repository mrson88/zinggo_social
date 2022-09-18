import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:zinggo_social/blocs/authentication/auth_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/screens/qrcode_screen/creatqr.dart';
import 'package:zinggo_social/screens/qrcode_screen/scanqr.dart';
import 'package:zinggo_social/screens/screens.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  static const String id = 'Profile_Page';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: id),
      builder: (_) => const Profile_Page(),
    );
  }

  @override
  _Profile_Page createState() => _Profile_Page();
}

class _Profile_Page extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    final email = FacebookAuth.instance.permissions;
    const profile = FacebookPermission.publicProfile;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.popAndPushNamed(context, LoginPage.id);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              Text(
                'Email: \n ${user.email}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              user.photoURL != null
                  ? Image.network("${user.photoURL}")
                  : Container(),
              user.displayName != null
                  ? Text("${user.displayName}")
                  : Container(),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () {
                  // Signing out the user
                  context.read<AuthBloc>().add(SignOutRequested());
                  Navigator.popAndPushNamed(context, Home_Login.id);
                },
              ),
              Text(
                'Email: \n ${email.toString()}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  print("tapped on create QR button.");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const QrCode(),
                    ),
                  );
                },
                child: const Text("Create QR"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("tapped on scan QR button.");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ScanScreen(),
                    ),
                  );
                },
                child: const Text("Scan QR"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
