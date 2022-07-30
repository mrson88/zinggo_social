import 'package:flutter/material.dart';
import 'package:zinggo_social/blocs/blocs.dart';
import 'package:zinggo_social/blocs/authentication/auth_bloc.dart';
import 'package:zinggo_social/repositories/repositories.dart';
import 'package:zinggo_social/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
          initialRoute: Home_Login.id,
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
