import 'package:flutter/material.dart';
import '/screens/screens.dart';

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
      case NotificationPage.id:
        return NotificationPage.route();
      case MesHomePage.id:
        return MesHomePage.route();
      case Home2.id:
        return Home2.route();
      case ControlHomePage.id:
        return ControlHomePage.route();
      case HomeTest.id:
        return HomeTest.route();
      case HomeTest2.id:
        return HomeTest2.route();
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
