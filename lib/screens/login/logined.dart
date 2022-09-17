import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zinggo_social/blocs/authentication/auth_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class LogIned extends StatefulWidget {
  static const String id = 'LogIned';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: id),
      builder: (_) => LogIned(),
    );
  }

  @override
  _LogIned createState() => _LogIned();
}

class _LogIned extends State<LogIned> {
  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            }
          },
          child: Center(
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
                    child: Icon(Icons.arrow_back),
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
                  },
                ),
                ElevatedButton(
                  child: const Text('Sign'),
                  onPressed: () {
                    // Signing out the user
                    Navigator.pushNamed(context, ControlHomePage.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
