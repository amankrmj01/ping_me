import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ping_me/consts/firebase_const.dart';

import '../../modals/message.dart';

class ChatServices {
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection(userCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  lastMessage(String chatRoom, String message) async {
    await firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('status')
        .doc('last message')
        .set(
      {'message': message, 'timestamp': Timestamp.now()},
      SetOptions(merge: true),
    );
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    final String currentEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        timestamp: timestamp,
        message: message,
        receiverId: receiverId,
        senderEmail: currentEmail,
        senderId: currentUserId);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoom = ids.join('_');

    await firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .add(newMessage.toMap());
    lastMessage(chatRoom, message);
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherId) {
    List<String> ids = [userId, otherId];
    ids.sort();
    String chatRoom = ids.join('_');

    return firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<Map<String, dynamic>> getLastMessageStream(
      String userId, String otherId) {
    List<String> ids = [userId, otherId];
    ids.sort();
    String chatRoom = ids.join('_');

    return firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('status')
        .doc('last message')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return {'message': '', 'timestamp': ''};
      } else {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return {
          'message': data['message'] ?? '',
          'timestamp': data['timestamp'] ?? ''
        };
      }
    });
  }

  void setUserStatusOffline() async {
    final String currentUserId = auth.currentUser!.uid;
    await firestore.collection(userCollection).doc(currentUserId).set({
      'status': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  void setUserStatusOnline() async {
    final String currentUserId = auth.currentUser!.uid;
    await firestore.collection(userCollection).doc(currentUserId).set({
      'status': 'Online',
    }, SetOptions(merge: true));
  }
}
