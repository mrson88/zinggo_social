import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zinggo_social/modules/chat_screen/screens/home_page.dart';
import 'package:zinggo_social/modules/map/screens/mapscreen.dart';
import 'package:zinggo_social/modules/notification/screens/notification_page.dart';
import 'package:zinggo_social/modules/post_detail/screens/post_page.dart';
import 'package:zinggo_social/modules/profile/screens/profile_page.dart';
import 'package:zinggo_social/themes/app_color.dart';

class AppNavigationConfig extends StatefulWidget {
  const AppNavigationConfig({Key? key}) : super(key: key);

  @override
  State<AppNavigationConfig> createState() => _AppNavigationConfigState();
}

class _AppNavigationConfigState extends State<AppNavigationConfig> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).brightness;
    return CupertinoTabScaffold(
      backgroundColor: AppColors.white,
      tabBar: CupertinoTabBar(
        activeColor: AppColors.paleGrey,
        inactiveColor:
            themeData == Brightness.dark ? AppColors.paleGrey : AppColors.dark,
        backgroundColor: themeData == Brightness.dark
            ? AppColors.dark
            : AppColors.lightBlueGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Noti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: PostPage(),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: MapScreen(),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: HomeChatPage(),
                );
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: NotificationPage(),
                );
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Profile_Page(),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: PostPage(),
                );
              },
            );
        }
      },
    );
  }
}
