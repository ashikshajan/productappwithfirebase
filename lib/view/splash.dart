import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techware_machinetest/utils/Utils.dart';
import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/utils/sharedprefs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    route(context);
    return Scaffold(
      backgroundColor: AppUtil.appclrwhite,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              image: AssetImage(assetImages("icon.jpeg")),
              width: 100,
              height: 100),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Welcome to Techware Labs",
            style: TextStyle(
                color: AppUtil.appprimaryclr,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ],
      )),
    );
  }

  route(BuildContext context) async {
    var loggedin = await SharedPrefsUtil.getString(SharedPrefsUtil.loggedin);

    Future.delayed(const Duration(seconds: 3), () {
      if (loggedin == "true") {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.login);
      }
    });
  }
}
