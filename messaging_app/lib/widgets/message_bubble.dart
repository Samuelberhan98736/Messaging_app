import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;
  final DateTime timestamp;

  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.isMe,
    required this.timestamp,
  });

  String _format(DateTime time) {
    return DateFormat('MM/dd • HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue.shade400 : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: isMe ? const Radius.circular(14) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _format(timestamp),
              style: TextStyle(
                fontSize: 11,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
