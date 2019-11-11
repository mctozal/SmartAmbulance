import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:smart_ambulance/states/managerState.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:smart_ambulance/states/settingState.dart';
import 'src/authentication/landingPage.dart';

void main() {
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: MapState()),
      ChangeNotifierProvider.value(value: HospitalState()),
      ChangeNotifierProvider.value(value: SettingState()),
      ChangeNotifierProvider.value(value: AuthenticationState()),
      ChangeNotifierProvider.value(value: ManagerState())
    ],
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
      theme: settingState.darkModeEnabled?ThemeData.dark():ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
