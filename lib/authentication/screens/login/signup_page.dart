import 'package:flutter/material.dart';
import 'package:zinggo_social/authentication/screens/login/home_login_page.dart';
import 'package:zinggo_social/authentication/screens/login/logined.dart';
import '../../../themes/app_color.dart';
import '../../comp/constants.dart';
import '../../comp/round_btn.dart';
import 'package:zinggo_social/authentication/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static String id = 'signup_screen';

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.pushNamed(context, LogIned.id);
            }
            if (state is AuthError) {
              // Displaying the error message if the user is not authenticated
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is Loading) {
              // Displaying the loading indicator while the user is signing up
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnAuthenticated) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/background_img/image_signup.png'),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, Home_Login.id);
                              },
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: const Text(
                                    'Create an account',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 34),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),

                              const SizedBox(
                                height: 58,
                              ),
                              // nInput(text:),

                              kInputDecoration(
                                text: 'Username',
                                obs: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              nInputDecoration(
                                  text: 'Email',
                                  obs: false,
                                  controller: _emailController),
                              const SizedBox(
                                height: 10,
                              ),
                              kInputDecoration(
                                text: 'Phone',
                                obs: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              kInputDecoration(
                                text: 'Date of birth',
                                obs: false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              nInputDecoration(
                                  text: "Password",
                                  obs: true,
                                  controller: _passwordController),
                              const SizedBox(
                                height: 40,
                              ),

                              RoundButton(
                                height: 44,
                                text: 'SIGN UP',
                                size: 20,
                                onPressed: () {
                                  _createAccountWithEmailAndPassword(context);
                                },
                                color: Colors.white,
                                gradient: const LinearGradient(colors: [
                                  AppColors.tanHide,
                                  AppColors.redMedium
                                ]),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                          const Text(
                              'By clicking Sign up you agree to the following\n Terms and Conditions without reservation '),
                          const SizedBox(
                            height: 38,
                          ),
                        ],
                      ),
                    ),
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

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }
}
