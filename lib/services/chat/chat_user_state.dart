import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../consts/firebase_const.dart';

class UserStatus extends StatelessWidget {
  final String userId;
  final textStyle = const TextStyle(fontSize: 12, color: Colors.black);

  const UserStatus({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection(userCollection).doc(userId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text("Loading...");
          default:
            var data = snapshot.data!.data() as Map<String, dynamic>;
            var status = data['status'];
            if (status == null) {
              return const Text("Status unknown");
            } else if (status is Timestamp) {
              var now = Timestamp.now();
              var difference = now.seconds - status.seconds;
              if (difference < 60) {
                return Text(
                  "Last active $difference seconds ago",
                  style: textStyle,
                );
              } else if (difference < 3600) {
                return Text(
                  "Last active ${difference ~/ 60} minutes ago",
                  style: textStyle,
                );
              } else {
                return Text(
                  "Last active ${difference ~/ 3600} hours ago",
                  style: textStyle,
                );
              }
            } else {
              return Text(status);
            }
        }
      },
    );
  }
}
