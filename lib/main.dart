import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/settingState.dart';
import 'package:smart_ambulance/ui/authentication/landingPage.dart';
import 'provider.dart';

void main() {
  return runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final settingState = Provider.of<SettingState>(context);
    return MaterialApp(
      title: 'Smart Ambulance',
      theme:
          settingState.darkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
