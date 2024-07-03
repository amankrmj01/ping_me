import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ping_me/consts/firebase_const.dart';
import 'chat_bubble.dart';
import 'chat_services.dart';
import 'chat_user_state.dart';

class ChatPage extends StatefulWidget {
  final String receivedEmail;
  final String receiverId;
  final String name;

  const ChatPage(
      {super.key,
      required this.receivedEmail,
      required this.receiverId,
      required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final ValueNotifier<bool> _isLoaded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: const [],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name),
            UserStatus(userId: widget.receiverId),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: _buildMessageList(),
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.all(5),
            child: _userInput(context),
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = auth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessage(widget.receiverId, senderID),
      builder: (builder, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollDown();
        });
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) {
            return _buildMessageItem(doc);
          }).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool currentUser = data['senderID'] == auth.currentUser!.uid;
    var alignment = currentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: alignment,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                currentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChatBubble(message: data['message'], isCurrentUser: currentUser),
              Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(formatTimestamp(data['timestamp']))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInput(BuildContext context) {
    final focusNode = FocusNode();
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _messageController,
            builder: (context, value, child) {
              return TextField(
                focusNode: focusNode,
                controller: _messageController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    enableFeedback: true,
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, size: 35),
                  ),
                  hintText: 'Type a Message',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.amber)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverId, _messageController.text.toString());
      _messageController.clear();
    }
    scrollDown();
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();

    var formatter = DateFormat('hh:mm a');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
