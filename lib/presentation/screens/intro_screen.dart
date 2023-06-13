import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../routes/app_routes.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/splash_image.jpeg",
                    width: 70.w, height: 15.h),
              ],
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  fixedSize: MaterialStateProperty.all<Size>(Size(60.w, 15.h)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.testNet);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.speed),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Test Internet Speed',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  fixedSize: MaterialStateProperty.all<Size>(Size(60.w, 15.h)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.googleMapPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Go to Map',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
