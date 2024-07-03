import 'package:flutter/material.dart';
import 'package:emoji_finder/emoji_finder.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late bool _emoji;

  bool emoji(String message) {
    return emojiFinder(message);
  }

  @override
  void initState() {
    _emoji = emoji(widget.message);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.75;
    double textWidth = (widget.message.length * 10.0).clamp(0.0, maxWidth);
    return !_emoji
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(bottom: 0, top: 0, right: 5, left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.isCurrentUser
                  ? Color.lerp(Colors.pink, Colors.white.withRed(250), 0.8)
                  : Colors.white,
            ),
            child: SizedBox(
              width: textWidth, // Adjusted width
              child: Text(
                widget.message,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            margin: const EdgeInsets.only(bottom: 0, top: 0, right: 5, left: 5),
            color: Colors.transparent,
            child: Text(
              widget.message,
              style: const TextStyle(fontSize: 40),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
