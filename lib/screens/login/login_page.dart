import 'package:flutter/material.dart';
import 'package:zinggo_social/screens/screens.dart';
import '../../../themes/app_color.dart';
import 'package:zinggo_social/widgets/round_btn.dart';
import 'package:zinggo_social/widgets/constants.dart';
import 'forgot_pass_page.dart';
import 'package:zinggo_social/blocs/authentication/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logined.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'Login_Page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  navigateToDashboard() async {
    Navigator.pushNamed(context, LogIned.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
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
            return SafeArea(
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background_img/image_login.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Navigator.popAndPushNamed(
                                    context, Home_Login.id);
                              },
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: const Text(
                                    'Welcome back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 34),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: const Text(
                                  'Login to your account',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              const SizedBox(
                                height: 58,
                              ),
                              nInputDecoration(
                                text: 'Email',
                                obs: false,
                                controller: _emailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              nInputDecoration(
                                text: 'Password',
                                obs: true,
                                controller: _passwordController,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              RoundButton(
                                height: 44,
                                text: 'LOGIN',
                                size: 20,
                                onPressed: () {
                                  _authenticateWithEmailAndPassword(context);
                                },
                                color: Colors.white,
                                gradient: LinearGradient(colors: [
                                  AppColors.tanHide,
                                  AppColors.redMedium
                                ]),
                              ),
                              const SizedBox(
                                height: 53,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Forgot_Pass_page.id);
                                  },
                                  child: Text('Forgot your password'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
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
}
