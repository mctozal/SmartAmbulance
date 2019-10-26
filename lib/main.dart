import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:smart_ambulance/ui/homepage.dart';

void main() {
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: MapState()),
      ChangeNotifierProvider.value(value: HospitalState())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ambulance',
      theme: ThemeData.light(),
      darkTheme: ThemeData(
    brightness: Brightness.light,
  ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}
