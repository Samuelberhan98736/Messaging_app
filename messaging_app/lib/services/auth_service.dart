import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // LOGIN
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } catch (e) {
      return e.toString();
    }
  }

  // REGISTER
  Future<String?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String role = "user",
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = credential.user!.uid;

      // Save user info in Firestore
      await _db.collection("users").doc(uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role,
        "createdAt": Timestamp.now(),
      });

      return null; // success
    } catch (e) {
      return e.toString();
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}
