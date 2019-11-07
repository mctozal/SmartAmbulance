import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/authenticationState.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _newEmailController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();

const String logoTitle = "SMART AMBULANCE";
const String logoSubTitle = "GROWTH * HAPPENS * TODAY";
const String signInMenuButton = "SIGN IN";
const String signUpMenuButton = "SIGN UP";
const String hintTextEmail = "Email";
const String hintTextPassword = "Password";
const String hintTextNewEmail = "Enter your Email";
const String hintTextNewPassword = "Enter a Password";
const String signUpButtonText = "SIGN UP";
const String signInWithEmailButtonText = "Sign in with Email";
const String signInWithAnonymouslyButtonText = "Sign in with Anonymously";
const String alternativeLogInSeparatorText = "or";
const String emailLogInFailed =
    "Email or Password was incorrect. Please try again";

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final authenticationState = Provider.of<AuthenticationState>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Builder(
          builder: (context) => new Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ])),
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  //Sets the main padding all widgets has to adhere to.
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  logoTitle,
                                ),
                                Text(
                                  logoSubTitle,
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                OutlineButton(
                                  onPressed: () =>
                                      authenticationState.changeToSignIn(),
                                  borderSide: new BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                  child: new Text(
                                    signInMenuButton,
                                  ),
                                ),
                                OutlineButton(
                                  onPressed: () =>
                                      authenticationState.changeToSignUp(),
                                  borderSide: BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                  child: Text(
                                    signUpMenuButton,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        width: 750,
                        height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: authenticationState.signInActive
                                ? _showSignIn(context)
                                : _showSignUp(context)),
                        width: 750,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}

Widget _showSignIn(context) {
  final authenticationState = Provider.of<AuthenticationState>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: TextField(
            style: TextStyle(color: Theme.of(context).accentColor),
            controller: _emailController,
            decoration: InputDecoration(
              hintText: hintTextEmail,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            obscureText: false,
          ),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Theme.of(context).accentColor),
            controller: _passwordController,
            decoration: InputDecoration(
              //Add th Hint text here.
              hintText: hintTextPassword,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: RaisedButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.mail),
                Expanded(
                  child: Text(
                    signInWithEmailButtonText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            color: Colors.blueGrey,
            onPressed: () => authenticationState.tryToLogInUserViaEmail(
                context, _emailController, _passwordController),
          ),
        ),
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(alternativeLogInSeparatorText)],
          ),
        ),
      ),
      Container(
        child: Padding(
            padding: EdgeInsets.only(),
            child: RaisedButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_box),
                  Expanded(
                    child: Text(
                      signInWithAnonymouslyButtonText,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              color: Color(0xFF3C5A99),
              onPressed: () => authenticationState.signInAnonymously(),
            )),
      ),
    ],
  );
}

Widget _showSignUp(context) {
  final authenticationState = Provider.of<AuthenticationState>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: TextField(
            obscureText: false,
            controller: _newEmailController,
            decoration: InputDecoration(
              //Add th Hint text here.
              hintText: hintTextNewEmail,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: TextField(
            obscureText: true,
            controller: _newPasswordController,
            decoration: InputDecoration(
              //Add the Hint text here.
              hintText: hintTextNewPassword,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0)),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Container(
        child: Padding(
          padding: EdgeInsets.only(),
          child: RaisedButton(
            child: Text(
              signUpMenuButton,
            ),
            color: Colors.blueGrey,
            onPressed: () => authenticationState.signUpWithEmailAndPassword(
                _newEmailController, _newPasswordController),
          ),
        ),
      ),
    ],
  );
}