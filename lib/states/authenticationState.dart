import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/states/crudState.dart';
import 'package:smart_ambulance/ui/homepage.dart';

class AuthenticationState with ChangeNotifier {
  bool isOnline = true;
  CRUDState crudState = new CRUDState();

  String uid;
  String get uids => uid;
  String smsCode;
  String verificationId;

  Future<void> signOut() async {
    try {
      isOnline = false;
      updateFirebase();
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
      TextEditingController email,TextEditingController phone, TextEditingController tc, TextEditingController password ) async {
    try { /*
      if(phone.text==null){   DUZELTILECEK 
        print('HATA'); 
      }*/  
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim().toLowerCase(), password: password.text );
      isOnline = true;
      addToFirebase(email.text.trim().toLowerCase(), password.text,
          result.user.uid, name.text ,phone.text ,tc.text );
      print('Signed up: ${result.user.uid}');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future tryToLogInUserViaEmail(context, email, password) async {
    if (await signInWithEmail(context, email, password) == true) {
      isOnline = true;
      updateFirebase();
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

  Future<void> addToFirebase(email, password, uid, name , phone ,tc) async {
    User user = new User(
        mail: email,
        isOnline: true,
        name: name,
        password: password,
        role: 'user',
        uid: uid ,
        phone:phone,
        tc :tc );
    crudState.addProduct(user, uid);
  }

  Future<void> updateFirebase() async {
    if (uid != 'PuFBc2GcqzaLh3gTGK8PryjDVC43' && uid != null) {
      try {
        User user = new User(isOnline: isOnline);
        crudState.updateProduct(user, uid);
      } catch (e) {
        print(e);

        // eğer id geldiyse yakala anonymous kullanıcı kaydını oluştur
        /*     await fireStore.collection('users-anonymous').document(uid).setData(
            {'uid': uid, 'name': "anonymous", 'isOnline': isOnline},
            merge: false); */

      }
    }
  }
}
/*  Future<bool> signUpWithPhoneNumber(
      TextEditingController email, BuildContext context) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String id) {
      verificationId = id;
    };

    Future<bool> smsCodeDialog(BuildContext context) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Enter SMS Code'),
              content: TextField(
                onChanged: (value) {
                  smsCode = value;
                },
              ),
              contentPadding: EdgeInsets.all(10),
              actions: <Widget>[
                FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user!= null) {
                        Navigator.of(context).pop();
                      } else {
                         Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                      }  // Düzenlenecek else blogu 
                    });
                  },
                ),
              ],
            );
          });
    }

    final PhoneCodeSent smsCodeSent = (String id, [int forceCodeResend]) {
      verificationId = id;
      smsCodeDialog(context).then((value) {
        print('signed in'); 
        notifyListeners();
      });
      notifyListeners();
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      print('verified');
      notifyListeners();
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('verified');
      notifyListeners();
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: email.text,
        codeSent: smsCodeSent,
        timeout: Duration(seconds: 10),
        codeAutoRetrievalTimeout: autoRetrieve,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed,
      );
      isOnline = true;
      print('Signed up: ');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

 */ 