import 'package:flutter/material.dart';
import 'package:zinggo_social/screens/screens.dart';
import '../../../themes/app_color.dart';
import 'package:zinggo_social/widgets/constants.dart';
import 'package:zinggo_social/widgets/round_btn.dart';
import 'package:zinggo_social/blocs/authentication/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = 'signup_screen';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: id),
      builder: (_) => SignUpPage(),
    );
  }

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateofbirthController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _dateofbirthController.dispose();
    _phoneController.dispose();
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
                                FocusScope.of(context).unfocus();
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

                              nInputDecoration(
                                  text: 'Username',
                                  obs: false,
                                  controller: _usernameController),
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

                              nInputDecoration(
                                  text: "Phone",
                                  obs: false,
                                  controller: _phoneController),
                              const SizedBox(
                                height: 10,
                              ),

                              nInputDecoration(
                                  text: 'Date of birth',
                                  obs: false,
                                  controller: _dateofbirthController),
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

                                  print(_usernameController.text);
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
      _firestore.collection('users').add({
        'dateofbirth': _dateofbirthController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'username': _usernameController.text,
      });
    }
  }
}
