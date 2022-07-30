import 'package:flutter/material.dart';
import 'package:zinggo_social/screens/screens.dart';
import '../../../themes/app_color.dart';
import 'package:zinggo_social/widgets/round_btn.dart';
import 'package:zinggo_social/widgets/constants.dart';

class Forgot_Pass_page extends StatefulWidget {
  const Forgot_Pass_page({Key? key}) : super(key: key);
  static String id = 'forgot_pass_screen';

  @override
  State<Forgot_Pass_page> createState() => _forgot_pass_page();
}

class _forgot_pass_page extends State<Forgot_Pass_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage('assets/images/background_img/image_forgot.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.popAndPushNamed(context, LoginPage.id);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: const Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.white, fontSize: 34),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        'Please enter your email address. You will\n receive a link to create a new password\n via email.',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 58,
                    ),
                    kInputDecoration(
                      text: 'Your email',
                      obs: false,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RoundButton(
                      height: 44,
                      text: 'SEND',
                      size: 20,
                      onPressed: () {},
                      color: Colors.white,
                      gradient: LinearGradient(
                          colors: [AppColors.tanHide, AppColors.redMedium]),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
