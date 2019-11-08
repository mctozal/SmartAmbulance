import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/src/authentication/signInPage.dart';
import 'package:smart_ambulance/states/managerState.dart';
import 'package:smart_ambulance/states/mapState.dart';
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
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          if (user.email == "admin@admin.com") {
            final managerState = Provider.of<ManagerState>(context);
            managerState.getUserId(user.uid);
            return RouteManager();
          }
          // If user is online MapState.uid = user.uid.
          final appState = Provider.of<MapState>(context);

          appState.uid = user.uid;
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
