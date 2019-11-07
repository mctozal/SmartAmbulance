import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/authenticationState.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final authenticationState = Provider.of<AuthenticationState>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Center(
        child: RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: authenticationState.signInAnonymously,
        ),
      ),
    );
  }
}