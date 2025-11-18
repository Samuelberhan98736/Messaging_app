import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String boardId;
  final String boardName;

  const ChatScreen({
    super.key,
    required this.boardId,
    required this.boardName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgController = TextEditingController();

  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (_msgController.text.trim().isEmpty || user == null) return;

    await FirebaseFirestore.instance
        .collection("boards")
        .doc(widget.boardId)
        .collection("messages")
        .add({
      "message": _msgController.text.trim(),
      "sender": user.email ?? "Unknown", // username or display name could go here
      "createdAt": Timestamp.now(),
    });

    _msgController.clear();
  }

  String _formatTimestamp(Timestamp ts) {
    final dt = ts.toDate();
    return DateFormat('MM/dd/yyyy • HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("boards")
                  .doc(widget.boardId)
                  .collection("messages")
                  .orderBy("createdAt", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final msg = docs[index].data();
                    final sender = msg['sender'] ?? 'Unknown';
                    final message = msg['message'] ?? '';
                    final createdAt = msg['createdAt'] as Timestamp;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(message),
                        subtitle: Text(
                          '$sender • ${_formatTimestamp(createdAt)}',
                        ),
                        tileColor: Colors.blue.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Input Area
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
