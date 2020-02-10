import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/provider.dart';
import 'package:smart_ambulance/states/settingState.dart';
import 'package:smart_ambulance/ui/Authentication/landingPage.dart';
import 'package:splashscreen/splashscreen.dart';

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
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: LandingPage(),
        loadingText: Text('Smart Ambulance'),
        image: Image.asset('images/ambulance.png'),
        photoSize: 100,
      ),
    );
  }
}
