import 'package:flutter/material.dart';

class AppConstants {
  // Common paddings
  static const double padding = 16.0;
  static const double inputSpacing = 14.0;

  // Firestore collections
  static const String usersCollection = "users";
  static const String boardsCollection = "boards";
  static const String messagesCollection = "messages";

  // Default boards (if you want to use a shared list)
  static const List<Map<String, dynamic>> defaultBoards = [
    {"id": "general", "name": "General Chat", "icon": Icons.forum},
    {"id": "school", "name": "School Talk", "icon": Icons.school},
    {"id": "gaming", "name": "Gaming", "icon": Icons.sports_esports},
    {"id": "random", "name": "Random", "icon": Icons.casino},
  ];
}
