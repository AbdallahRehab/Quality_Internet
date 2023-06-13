import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_speed_test/presentation/core/setup_providers/setup_providers.dart';
import 'package:internet_speed_test/presentation/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await diInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
              title: 'Internet Speed',
              debugShowCheckedModeBanner: false,
              // locale: const Locale("ar"),
              theme: ThemeData(
                fontFamily: "Poppins",
                appBarTheme: const AppBarTheme(
                  color: Colors.black,
                ),
              ),
              initialRoute: AppRoutes.splashScreen,
              onGenerateRoute: AppRoutes.appRoutes);
        }));
  }
}
