import 'package:flutter/material.dart';
import 'package:zinggo_social/authentication/bloc/auth_bloc.dart';
import 'package:zinggo_social/authentication/repository/auth_repository.dart';
import 'package:zinggo_social/home/repository/post_repository.dart';
import 'package:zinggo_social/authentication/screens/login/home_login_page.dart';
import 'authentication/screens/login/login_page.dart';
import 'authentication/screens/login/forgot_pass_page.dart';
import 'authentication/screens/login/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zinggo_social/authentication/screens/login/logined.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zinggo_social/authentication/screens/login/notification_screen_pick.dart';
import 'package:zinggo_social/home/screens/mes_page.dart';
import 'package:zinggo_social/home/screens/home_2.dart';
import 'package:zinggo_social/home/screens/control_home.dart';

import 'package:zinggo_social/home/screens/home_test.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => PostRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ZinGo Social',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: HomeTest.id,
          routes: {
            Home_Login.id: (context) => Home_Login(),
            LoginPage.id: (context) => const LoginPage(),
            Forgot_Pass_page.id: (context) => const Forgot_Pass_page(),
            SignUpPage.id: (context) => const SignUpPage(),
            LogIned.id: (context) => LogIned(),
            NotificationPage.id: (context) => const NotificationPage(),
            MesHomePage.id: (context) => const MesHomePage(),
            Home2.id: (context) => const Home2(),
            ControlHomePage.id: (context) => const ControlHomePage(),
            HomeTest.id: (context) => const HomeTest(),
          },
        ),
      ),
    );
  }
}
