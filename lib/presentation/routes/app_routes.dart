import 'package:flutter/material.dart';

import '../screens/intro_screen.dart';
import '../screens/map/search_map_page.dart';
import '../screens/splash_screen.dart';
import '../screens/test_net.dart';

class AppRoutes {
  // static const initializer = '/';
  static const splashScreen = '/';
  static const introScreen = '/introScreen';
  static const testNet = '/testNet';
  static const geolocatorWidget = '/GeolocatorWidget';
  static const googleMapPage = '/GoogleMapPage';

  static Route<dynamic> appRoutes(RouteSettings? settings) {
    final args = settings!.arguments;
    switch (settings.name!) {
      case testNet:
        return MaterialPageRoute(builder: (context) => const TestNet());

      case googleMapPage:
        return MaterialPageRoute(builder: (context) => GoogleMapPage());

      case introScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());

      case splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text("not found screen"),
        ),
      ),
    );
  }
}
