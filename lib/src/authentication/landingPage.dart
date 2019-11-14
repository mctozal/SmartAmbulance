import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/src/authentication/signInPage.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/ui/RouteManager/routeManager.dart';
import 'package:smart_ambulance/ui/homepage.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final authenticationState = Provider.of<AuthenticationState>(context);
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          if (user.email == "admin@admin.com") {
            return RouteManager();
          }
          if (snapshot.hasError) {
            authenticationState.isOnline = false;
            authenticationState.updateFirebase();
          }
          // If user is online MapState.uid = user.uid.

          authenticationState.uid = user.uid;
          authenticationState.isOnline = true;
          return HomePage();
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
