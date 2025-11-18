import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String message;
  final String sender;
  final String senderId;
  final Timestamp createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.senderId,
    required this.createdAt,
  });

  // Convert Firestore document → Message object
  factory MessageModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return MessageModel(
      id: doc.id,
      message: data['message'] ?? '',
      sender: data['sender'] ?? 'Unknown',
      senderId: data['senderId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  // Convert Message object → Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sender': sender,
      'senderId': senderId,
      'createdAt': createdAt,
    };
  }
}
