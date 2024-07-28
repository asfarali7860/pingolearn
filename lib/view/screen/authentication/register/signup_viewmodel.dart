// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingolearn/data/remote/users/user_model.dart';
import 'package:pingolearn/routes/app_routes.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel userDetails = UserModel();

  Future<void> signInWithEmail(String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        userDetails = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        notifyListeners();
        context.pushReplacementNamed(AppRoute.homeScreen.name);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel?> signUpWithEmail(String email, String password, String name) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        UserModel newUser = UserModel(uid: user.uid, name: name, email: email);
        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        return newUser;
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((User? user) async {
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
