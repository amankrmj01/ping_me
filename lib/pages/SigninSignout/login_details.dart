import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ping_me/services/auth_services.dart';
import 'package:ping_me/widgets_common/customButton_widget.dart';

import '../../components/my_text_filed.dart';
import '../Main/mainScreen.dart';

class LoginDetails extends StatefulWidget {
  final void Function()? onTap;

  const LoginDetails({super.key, required this.onTap});

  @override
  State<LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  AuthControllers auth = Get.put(AuthControllers());

  void showDialogWithText(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(
            keyboardType: TextInputType.text,
            controller: _email,
            text: 'Username',
            visible: false,
            icon: const Icon(Icons.person),
          ),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
            keyboardType: TextInputType.visiblePassword,
            controller: _password,
            text: 'Password',
            visible: true,
            icon: const Icon(Icons.lock_outline),
          ),
          const SizedBox(
            height: 30,
          ),
          customButton(
            context: context,
            text: 'Login',
            onPressed: () {
              auth
                  .loginMethod(email: _email.text, password: _password.text)
                  .then((value) {
                if (value != null) {
                  Get.off(() => const MainScreen());
                } else {
                  Fluttertoast.showToast(msg: 'Invalid Details');
                }
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a member?',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: customButton(
                        backgroundColor:
                            Color.lerp(Colors.blue, Colors.pink, 0.5)!,
                        context: context,
                        text: 'SignUp',
                        onPressed: widget.onTap!),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
