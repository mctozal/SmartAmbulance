import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthenticationState with ChangeNotifier {
  bool _signUpActive = false;
  bool _signInActive = true;
  bool isOnline = true;
  Firestore fireStore = Firestore.instance;
  String uid;

  bool get signUpActive => _signUpActive;
  String get uids => uid;
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
      isOnline = false;
      updateFirebase();
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
      isOnline = true;
      updateFirebase();
      print('Signed in: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');

      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(TextEditingController name,
      TextEditingController email, TextEditingController password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text);
      isOnline = true;
      addToFirebase(email.text.trim().toLowerCase(), password.text,
          result.user.uid, name.text);
      print('Signed up: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future tryToLogInUserViaEmail(context, email, password) async {
    if (await signInWithEmail(context, email, password) == true) {
    } else {
      return Alert(
        context: context,
        type: AlertType.error,
        title: "Authentication Error!",
        desc: "Invalid email/username or password.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
    notifyListeners();
  }

  Future<void> addToFirebase(email, password, uid, name) async {
    await fireStore.collection('users').document(uid).setData({
      'user-mail': email,
      'user-password': password,
      'role': 'user',
      'uid': uid,
      'name': name,
      'isOnline': isOnline
    }, merge: false);
  }

  Future<void> updateFirebase() async {
    if (uid != 'PuFBc2GcqzaLh3gTGK8PryjDVC43' && uid != null) {
      try {
        await fireStore
            .collection('users')
            .document(uid)
            .updateData({'isOnline': isOnline});
      } catch (e) {
        print(e);
        // eğer id geldiyse yakala anonymous kullanıcı kaydını oluştur
        await fireStore.collection('users-anonymous').document(uid).setData(
            {'uid': uid, 'name': "anonymous", 'isOnline': isOnline},
            merge: false);
      }
    }
  }
}
