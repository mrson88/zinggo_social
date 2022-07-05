import 'package:flutter/material.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zinggo_social/authentication/screens/presentation/dashboard.dart';
import 'package:zinggo_social/authentication/screens/presentation/sign_in.dart';
import 'package:zinggo_social/authentication/screens/login/sign_up1.dart';

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
            SignUp1.id: (context) => SignUp1(),
          },
        ),
      ),
    );
  }
}
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider(
//       create: (context) => AuthRepository(),
//       child: BlocProvider(
//         create: (context) => AuthBloc(
//           authRepository: RepositoryProvider.of<AuthRepository>(context),
//         ),
//         child: MaterialApp(
//           home: StreamBuilder<User?>(
//               stream: FirebaseAuth.instance.authStateChanges(),
//               builder: (context, snapshot) {
//                 // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
//                 if (snapshot.hasData) {
//                   return const Dashboard();
//                 }
//                 // Otherwise, they're not signed in. Show the sign in page.
//                 return SignIn();
//               }),
//         ),
//       ),
//     );
//   }
// }
