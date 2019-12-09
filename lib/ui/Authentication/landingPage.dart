import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/ui/Manager/RouteHome.dart';
import 'package:smart_ambulance/ui/authentication/signInPage.dart';
import 'package:smart_ambulance/ui/homepage.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationState = Provider.of<AuthenticationState>(context);
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          if (user.email == "admin@admin.com") {
            return RouteManager();
          }
          // If user is online MapState.uid = user.uid.
          authenticationState.uid = user.uid;
          return MyHomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
