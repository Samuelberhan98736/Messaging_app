import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Send a message to a specific board
  Future<void> sendMessage({
    required String boardId,
    required String message,
  }) async {
    final user = _auth.currentUser;
    if (user == null || message.trim().isEmpty) return;

    await _db
        .collection("boards")
        .doc(boardId)
        .collection("messages")
        .add({
      "message": message.trim(),
      "sender": user.email ?? "Unknown",
      "senderId": user.uid,
      "createdAt": Timestamp.now(),
    });
  }

  /// Get real-time stream of messages for a board
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesStream(
      String boardId) {
    return _db
        .collection("boards")
        .doc(boardId)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  /// Create board if it does not exist (optional helper)
  Future<void> createBoardIfNotExists(String boardId, String name) async {
    final doc = _db.collection("boards").doc(boardId);
    final snapshot = await doc.get();

    if (!snapshot.exists) {
      await doc.set({
        "name": name,
        "createdAt": Timestamp.now(),
      });
    }
  }
}
