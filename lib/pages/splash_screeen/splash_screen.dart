import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ping_me/components/my_logo.dart';
import 'package:ping_me/pages/Main/mainScreen.dart';
import 'package:ping_me/pages/SigninSignout/login_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/firebase_const.dart';
import '../../services/chat/chat_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  jumpToScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    auth.currentUser != null
        ? Get.off(() => const MainScreen())
        : Get.off(() => const LoginPage());
  }

  final ChatServices _chatServices = Get.put(ChatServices());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _chatServices.setUserStatusOffline();
      return;
    }
    _chatServices.setUserStatusOnline();
  }

  @override
  initState() {
    jumpToScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.topCenter,
                    child: MyLogo(
                      size: 160,
                    )),
                20.heightBox,
                ('Ping Me').text.bold.size(28).extraBlack.make(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ('Version 1.0.0').text.make(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
