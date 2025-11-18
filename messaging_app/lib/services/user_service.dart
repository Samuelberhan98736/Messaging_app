import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get the current user's profile document
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserStream() {
    final user = _auth.currentUser;
    return _db.collection("users").doc(user!.uid).snapshots();
  }

  /// Load user profile once
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _db.collection("users").doc(user.uid).get();
    return doc.data();
  }

  /// Update the user's profile
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection("users").doc(user.uid).update({
      "firstName": firstName,
      "lastName": lastName,
      "role": role,
      "updatedAt": Timestamp.now(),
    });
  }

  /// Create user document after registration (for AuthService)
  Future<void> createUserDocument({
    required String uid,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
  }) async {
    await _db.collection("users").doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "role": role,
      "createdAt": Timestamp.now(),
    });
  }
}
