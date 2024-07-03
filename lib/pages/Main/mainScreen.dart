import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ping_me/consts/firebase_const.dart';
import '../../components/my_drawer.dart';
import '../../components/userTile.dart';
import '../../services/chat/chat_page.dart';
import '../../services/chat/chat_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerC(),
        appBar: AppBar(
          actions: const [],
          title: const Text(
            'Ping Me',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildingUserLists(),
        ));
  }

  Widget _buildingUserLists() {
    return StreamBuilder(
        stream: _chatServices.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildingUser(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildingUser(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _getCurrentUser()) {
      Stream<Map<String, dynamic>> lastMessageStream = _chatServices
          .getLastMessageStream(auth.currentUser!.uid, userData['uid']);
      return StreamBuilder<Map<String, dynamic>>(
        stream: lastMessageStream,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading...');
            default:
              String time = '';
              if (snapshot.data != null) {
                String lastMessage = snapshot.data?['message'] ?? '';
                if (snapshot.data?['timestamp'] != '') {
                  time = formatTimestamp(snapshot.data?['timestamp']);
                }
                return UserTile(
                    name: userData["name"],
                    message: lastMessage,
                    time: time,
                    onTap: () {
                      Get.to(
                        () => ChatPage(
                          receivedEmail: userData['email'],
                          receiverId: userData['uid'],
                          name: userData['name'],
                        ),
                      );
                    });
              } else {
                return const Text('No data');
              }
          }
        },
      );
    } else {
      return Container();
    }
  }

  String? _getCurrentUser() {
    return auth.currentUser!.email;
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    DateTime now = DateTime.now();

    if (now.difference(date).inDays < 1) {
      // If the timestamp is from today, return the time
      var formatter = DateFormat('hh:mm a');
      return formatter.format(date);
    } else {
      // If the timestamp is not from today, return the day
      var formatter = DateFormat('MMM d, yyyy');
      return formatter.format(date);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
}
