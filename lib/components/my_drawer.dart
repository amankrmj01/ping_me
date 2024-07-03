import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ping_me/services/auth_services.dart';
import 'package:ping_me/services/profile_controller.dart';

import '../pages/profile_screen/profile_screen.dart';
import '../pages/settings_screen/settings.dart';
import 'my_logo.dart';

class DrawerC extends StatefulWidget {
  const DrawerC({super.key});

  @override
  State<DrawerC> createState() => _DrawerCState();
}

class _DrawerCState extends State<DrawerC> {
  AuthControllers authControllers = Get.put(AuthControllers());
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    // double? statusBarHeight = Get.statusBarHeight;
    List items = [
      [
        const Text('Home'),
        Icons.home,
        () {
          Navigator.pop(context);
        }
      ],
      [
        const Text('Profile'),
        Icons.person_3_sharp,
        () {
          Navigator.pop(context);
          Get.to(() => const ProfileScreen());
        }
      ],
      [
        const Text('Settings'),
        Icons.settings,
        () {
          Navigator.pop(context);
          Get.to(() => const SettingsScreen());
        }
      ],
    ];
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      // margin: EdgeInsets.zero,
      child: Drawer(
        backgroundColor: Color.lerp(Colors.pink, Colors.white, 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 75,
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.zero,
              alignment: Alignment.center,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyLogo(
                    size: 0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
              color: Color.lerp(Colors.amber, Colors.black, 0.2),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: items[index][2],
                      title: items[index][0],
                      leading: Icon(items[index][1]),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    authControllers.signOut();
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded),
                      Text('LogOut'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
