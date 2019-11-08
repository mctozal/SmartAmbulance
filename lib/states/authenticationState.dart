import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationState with ChangeNotifier {
  bool _signUpActive = false;
  bool _signInActive = true;
  Firestore fireStore = Firestore.instance;

  bool get signUpActive => _signUpActive;

  bool get signInActive => _signInActive;

  void changeToSignUp() {
    _signUpActive = true;
    _signInActive = false;
    notifyListeners();
  }

  void changeToSignIn() {
    _signUpActive = false;
    _signInActive = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<bool> signInWithEmail(context, TextEditingController email,
      TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text);
      print('Signed in: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      TextEditingController email, TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text);
              addToFirebase(email.text.trim().toLowerCase(), password.text,result.user.uid);
      print('Signed up: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future tryToLogInUserViaEmail(context, email, password) async {
    if (await signInWithEmail(context, email, password) == true) {}
    notifyListeners();
  }
  
   Future<DocumentReference> addToFirebase(email,password,uid) {
    
    return fireStore
        .collection('users')
        .add({'user-mail': email, 'user-password':password,'role':'user','uid':uid });
  }
  

}
