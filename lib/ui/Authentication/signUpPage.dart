import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_ambulance/model/authentication.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:multi_page_form/multi_page_form.dart';

TextEditingController _newEmailController = TextEditingController();
TextEditingController _newPhoneController = TextEditingController();
TextEditingController _newNameController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();
TextEditingController _newTcController = TextEditingController();
TextEditingController _newAmbulancePlateController = TextEditingController();
TextEditingController _newVehicleLicenceController = TextEditingController();
TextEditingController _newVehicleLicenceDateController =
    TextEditingController();

Authentication model = new Authentication();

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Signup Page',
        style: TextStyle(
          fontSize: 16,
        ),
      )),
      body: Test2(),
    );
  }
}

class Test2 extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    final authenticationState =
        Provider.of<AuthenticationState>(context, listen: false);
    return MultiPageForm(
      totalPage: 2,
      pageList: <Widget>[page1(), page2()],
      onFormSubmitted: () {
        authenticationState.signUpWithEmailAndPassword(
            context,
            _newNameController,
            _newEmailController,
            _newPhoneController,
            _newTcController,
            _newPasswordController,
            _newAmbulancePlateController,
            _newVehicleLicenceController,
            _newVehicleLicenceDateController);
      },
    );
  }

  Widget page1() {
    return Container(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: false,
                  controller: _newNameController,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: model.hintTextName,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: false,
                  controller: _newEmailController,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: model.hintTextNewEmail,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: false,
                  controller: _newPhoneController,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: model.hintTextPhone,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: false,
                  controller: _newTcController,
                  decoration: InputDecoration(
                    //Add th Hint text here.
                    hintText: model.hintTextTc,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: TextField(
                  obscureText: true,
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    //Add the Hint text here.
                    hintText: model.hintTextNewPassword,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor, width: 1.0)),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ],
    ));
  }

  Widget page2() {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: TextField(
                    obscureText: false,
                    controller: _newAmbulancePlateController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: model.hintTextAmbulancePlate,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      prefixIcon: const Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: TextField(
                    obscureText: false,
                    controller: _newVehicleLicenceController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: model.hintTextVehicleLicence,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: TextField(
                    obscureText: false,
                    controller: _newVehicleLicenceDateController,
                    decoration: InputDecoration(
                      //Add th Hint text here.
                      hintText: model.hintTextVehicleLicenceDate,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
