// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingolearn/data/remote/users/user_model.dart';
import 'package:pingolearn/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel userDetails = UserModel();
  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', user.uid);
        await fetchUserData(user.uid, context);
        context.pushReplacementNamed(AppRoute.bottomScreen.name);
      }
    } catch (e) {
      log(e.toString());
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign in: ${e.toString()}')));
    } finally {
      _setLoading(false);
    }
  }

  Future<UserModel?> signUpWithEmail(String email, String password, String name) async {
    _setLoading(true);
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        UserModel newUser = UserModel(uid: user.uid, name: name, email: email);
        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        return newUser;
      }
    } catch (e) {
      log(e.toString());
      // Handle sign-up error
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      context.pushReplacementNamed(AppRoute.loginScreen.name);
    } catch (e) {
      log('Error signing out: $e');
    }
  }

  Future<void> fetchUserData(String uid, BuildContext context) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      log((userDoc.data() as Map<String, dynamic>).toString());
      userDetails = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      notifyListeners();
    } catch (e) {
      log('Error getting user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error getting user data: ${e.toString()}')));
    }
  }
}