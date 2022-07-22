import 'package:flutter/material.dart';
import 'package:zinggo_social/authentication/bloc/auth_bloc.dart';
import 'package:zinggo_social/authentication/repository/auth_repository.dart';
import 'package:zinggo_social/authentication/screens/login/home_login_page.dart';
import 'authentication/screens/login/login_page.dart';
import 'authentication/screens/login/forgot_pass_page.dart';
import 'authentication/screens/login/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zinggo_social/authentication/screens/login/logined.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/authentication/screens/login/notification_screen_pick.dart';
import 'package:zinggo_social/home/mes_page.dart';
import 'package:zinggo_social/home/home_2.dart';
import 'package:zinggo_social/home/control_home.dart';
import 'package:zinggo_social/home/downloadFile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Zinggo Social',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Home_Login.id,
          routes: {
            Home_Login.id: (context) => Home_Login(),
            LoginPage.id: (context) => const LoginPage(),
            Forgot_Pass_page.id: (context) => const Forgot_Pass_page(),
            SignUpPage.id: (context) => const SignUpPage(),
            LogIned.id: (context) => LogIned(),
            NotificationPage.id: (context) => NotificationPage(),
            MesHomePage.id: (context) => MesHomePage(),
            Home2.id: (context) => Home2(),
            ControlHomePage.id: (context) => ControlHomePage(),
            DownloadFile.id: (context) => DownloadFile(),
          },
        ),
      ),
    );
  }
}
