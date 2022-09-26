import 'package:flutter/material.dart';
import 'package:zinggo_social/modules/auth/blocs/auth_bloc.dart';
import 'package:zinggo_social/modules/auth/screens/login_page.dart';
import 'package:zinggo_social/modules/auth/screens/signup_page.dart';
import 'package:zinggo_social/modules/navigation/app_navigation.dart';

import '../../../themes/app_color.dart';
import 'package:zinggo_social/widgets/round_btn.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class Home_Login extends StatefulWidget {
  static const String id = 'Home_Login_Page';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: id),
      builder: (_) => Home_Login(),
    );
  }

  @override
  State<Home_Login> createState() => _Home_LoginState();
}

class _Home_LoginState extends State<Home_Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  navigateToLogin() async {
    // Navigator.pushNamed(context, LoginPage.id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  navigateToRegister() async {
    // Navigator.pushNamed(context, SignUpPage.id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  navigateToDashboard() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppNavigationConfig()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            navigateToDashboard();
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          // TODO: implement listener
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/background_img/home.png'),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: const Text(
                            'Find new\nfriends nearby',
                            style: TextStyle(color: Colors.white, fontSize: 44),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: const Text(
                          'With milions of users all over the world, we\n gives you the ability to connect with people\n no matter where you are.',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 44,
                      ),
                      RoundButton(
                        height: 44,
                        text: 'Login',
                        size: 20,
                        onPressed: () {
                          navigateToLogin();
                        },
                        color: Colors.red,
                        gradient: LinearGradient(
                            colors: [AppColors.white, AppColors.white]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundButton(
                        height: 44,
                        text: 'Sign Up',
                        size: 20,
                        onPressed: () {
                          navigateToRegister();
                        },
                        color: Colors.white,
                        gradient: LinearGradient(
                            colors: [AppColors.tanHide, AppColors.redMedium]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text('Or login with'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 142, top: 14, bottom: 30, right: 142),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _authenticateWithFacebook(context);

                                print('helle');
                              },
                              child:
                                  Image.asset('assets/images/icons/Path.png'),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                  'assets/images/icons/Twister.png'),
                            ),
                            InkWell(
                              onTap: () {
                                _authenticateWithGoogle(context);
                              },
                              child:
                                  Image.asset('assets/images/icons/google.png'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  void _authenticateWithFacebook(context) {
    BlocProvider.of<AuthBloc>(context).add(
      FacebookSigninRequested(),
    );
  }
}
