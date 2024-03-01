// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:techware_machinetest/main.dart';
import 'package:techware_machinetest/repository/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:techware_machinetest/utils/Utils.dart';
import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/utils/sharedprefs.dart';

class SignUpPageVM extends ChangeNotifier {
  final FirebaseAuthService auth = FirebaseAuthService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isSigning = false;

  bool get isSigning => _isSigning;

  loading(bool val) {
    _isSigning = val;

    notifyListeners();
  }

  void signUp(email, password) async {
    loading(true);

    User? user = await auth.signUpWithEmailAndPassword(email, password);

    loading(false);
    if (user != null) {
      showToast(message: "User is successfully created");

      SharedPrefsUtil.putString(SharedPrefsUtil.loggedin, "true");
      rootNavigatorKey.currentState!.context.go(AppRoutes.home);
    } else {
      showToast(message: "Some error happend");
    }
  }
}
