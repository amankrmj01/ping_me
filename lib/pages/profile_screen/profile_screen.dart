import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ping_me/components/custom_text_input.dart';
import 'package:ping_me/consts/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../services/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            20.heightBox,
            Container(
              alignment: Alignment.center,
              height: 160,
              child: ClipOval(
                child: Stack(
                  children: [
                    SizedBox(
                        height: 160,
                        width: 160,
                        child: Image.network(
                            'https://i.pinimg.com/736x/38/16/a9/3816a930470cb0e7d784f29421fc93b4.jpg')),
                    Positioned(
                      bottom: 0,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 160,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            radius: 20,
                            child: const Icon(
                                color: Colors.black, Icons.camera_alt),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(userCollection)
                  .doc(auth.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                _profileController.nameController.text = data['name'];
                _profileController.emailController.text = data['email'];

                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(children: [
                    16.heightBox,
                    customTextInput(
                        enabled: false,
                        context: context,
                        text: '',
                        hint: '',
                        controller: _profileController.nameController,
                        keyboardType: TextInputType.name),
                    16.heightBox,
                    customTextInput(
                        enabled: false,
                        context: context,
                        text: '',
                        hint: '',
                        controller: _profileController.emailController,
                        keyboardType: TextInputType.name),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
