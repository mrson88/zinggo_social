import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static String id = 'notification_page';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool notification = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff242a37),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/icons/bell.png'),
                    Image.asset('assets/images/icons/Oval.png'),
                    Image.asset('assets/images/icons/OvalCopy.png'),
                  ],
                ),
              ),
              Container(
                child: Text(
                  'Turn on \nNotification',
                  style: TextStyle(fontSize: 34, color: Colors.white),
                ),
              ),
              Container(
                child: Text(
                  'Enable push notifications to let send you \npersonal news and updates',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 41,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                height: 67,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Turn on notifications'),
                    Switch(
                      value: notification,
                      onChanged: (notification) {
                        print(notification);
                        notification = notification;
                      },
                      inactiveThumbColor: Colors.green,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
