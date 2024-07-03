import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ping_me/services/auth_services.dart';
import 'package:ping_me/widgets_common/customButton_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/my_text_filed.dart';
import '../Main/mainScreen.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  AuthControllers authControllers = Get.put(AuthControllers());

  void register(TextEditingController username, TextEditingController password,
      TextEditingController gmail) {
    if (_username.text.isEmpty &&
        _email.text.isEmpty &&
        _password.text.isEmpty) {}
  }

  String dropdownValue = 'Gender';
  List<String> genderList = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              keyboardType: TextInputType.text,
              controller: _username,
              text: 'Username',
              visible: false,
              icon: const Icon(Icons.person),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              text: 'Gmail',
              visible: false,
              icon: const Icon(Icons.alternate_email_outlined),
            ),
            const SizedBox(
              height: 30,
            ),
            dropDownMenu(context),
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
            MyTextField(
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmPassword,
              text: 'Password',
              visible: true,
              icon: const Icon(Icons.lock_outline),
            ),
            const SizedBox(
              height: 30,
            ),
            customButton(
                context: context,
                text: 'SignUp',
                onPressed: () {
                  authControllers
                      .signUpMethod(
                          email: _email.text, password: _password.text)
                      .then((value) {
                    authControllers.storeUserData(
                        uid: value!.user!.uid,
                        email: _email.text,
                        displayName: _username.text,
                        phoneNumber: '999',
                        photoURL: '',
                        countryCode: '+91');
                  });
                  Get.off(() => const MainScreen());
                }),
            20.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a member?',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: customButton(
                          size: 24,
                          backgroundColor:
                              Color.lerp(Colors.blue, Colors.pink, 0.5)!,
                          context: context,
                          text: 'Login',
                          onPressed: widget.onTap!),
                    ),
                  )
                ],
              ),
            ),
            40.heightBox,
          ],
        ),
      ),
    );
  }

  Future<bool> checkIfEmailExists(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

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

  Widget dropDownMenu(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return genderList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 20),
              ),
            );
          }).toList();
        },
        onSelected: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints.expand(width: width, height: 120),
        padding: const EdgeInsets.all(50),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dropdownValue, // Use the updated value here
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }
}
