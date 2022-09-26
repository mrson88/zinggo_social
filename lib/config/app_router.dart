import 'package:flutter/material.dart';
import 'package:zinggo_social/modules/auth/screens/forgot_pass_page.dart';
import 'package:zinggo_social/modules/auth/screens/home_login_page.dart';
import 'package:zinggo_social/modules/auth/screens/login_page.dart';
import 'package:zinggo_social/modules/auth/screens/logined.dart';
import 'package:zinggo_social/modules/auth/screens/notification_screen_pick.dart';
import 'package:zinggo_social/modules/auth/screens/signup_page.dart';
import 'package:zinggo_social/modules/chat_screen/screens/mes_page.dart';
import 'package:zinggo_social/modules/home/screens/create_post_page.dart';
import 'package:zinggo_social/screens/home2/post_page.dart';


class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case Home_Login.id:
        return Home_Login.route();
      case LoginPage.id:
        return LoginPage.route();
      case Forgot_Pass_page.id:
        return Forgot_Pass_page.route();
      case SignUpPage.id:
        return SignUpPage.route();
      case LogIned.id:
        return LogIned.route();

      case MesHomePage.id:
        return MesHomePage.route();



      case PostPage.id:
        return PostPage.route();
      case CreatePostPage.id:
        return CreatePostPage.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
