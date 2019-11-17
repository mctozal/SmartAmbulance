import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_ambulance/ui/Authentication/signInPage.dart';
import 'package:smart_ambulance/ui/homepage.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/map':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/manager':
        return MaterialPageRoute(builder: (_) => HomePage());
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
