import 'package:flutter/material.dart';
import 'package:zinggo_social/screens/home/home_2.dart';
import 'package:zinggo_social/screens/home/mes_page.dart';
import 'package:zinggo_social/screens/home/notification_page.dart';
import 'package:zinggo_social/screens/home2/post_page.dart';
import 'package:zinggo_social/widgets/navigationbar_item.dart';
import 'package:zinggo_social/themes/app_color.dart';

class ControlHomePage extends StatefulWidget {
  const ControlHomePage({Key? key}) : super(key: key);
  static const String id = 'Control_HomePage';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: id),
      builder: (_) => ControlHomePage(),
    );
  }

  @override
  State<ControlHomePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ControlHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PostPage(),
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    MesHomePage(),
    NotificationPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//ok
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber[800],
        currentIndex: _selectedIndex,
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          button_navigation(
              iconbar: 'assets/images/icons/navigationbar/Home.png',
              label: 'Home',
              color: AppColors.navigationColor),
          button_navigation(
              iconbar: 'assets/images/icons/navigationbar/streams.png',
              label: 'Stream',
              color: AppColors.navigationColor),
          button_navigation(
              iconbar: 'assets/images/icons/navigationbar/message.png',
              label: 'Message',
              color: AppColors.navigationColor),
          button_navigation(
              iconbar: 'assets/images/icons/navigationbar/Notification.png',
              label: 'Notification',
              color: AppColors.navigationColor),
          button_navigation(
              iconbar: 'assets/images/icons/navigationbar/profile.png',
              label: 'Profile',
              color: AppColors.navigationColor),
        ],
      ),
    );
  }
}
