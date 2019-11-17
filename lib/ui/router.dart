import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_ambulance/ui/homepage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return  MaterialPageRoute(
          builder: (_)=> HomePage()
        );
      case '/addProduct' :
        return MaterialPageRoute(
          builder: (_)=> HomePage()
        ) ;
      case '/productDetails' :
        return MaterialPageRoute(
            builder: (_)=> HomePage()
        ) ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}