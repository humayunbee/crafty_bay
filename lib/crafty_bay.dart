import 'package:crafty_bay/onboard/splash_screen.dart';
import 'package:crafty_bay/utilities/app_routes.dart';
import 'package:crafty_bay/utilities/app_theme_data.dart';
import 'package:crafty_bay/utilities/crafty_bay_dependency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crafty Bay',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      navigatorKey: navigationKey,
      initialBinding: CraftyBayDependency(),
      initialRoute: SplashScreen.routeName,
      getPages: AppRoutes.appRoutes,
    );
  }
}
