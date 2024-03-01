// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techware_machinetest/main.dart';
import 'package:techware_machinetest/repository/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:techware_machinetest/utils/Utils.dart';
import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/utils/sharedprefs.dart';

class LoginPageVM extends ChangeNotifier {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn(email, password) async {
    loading(true);

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    loading(false);

    if (user != null) {
      showToast(message: "User is successfully signed in");
      SharedPrefsUtil.putString(SharedPrefsUtil.loggedin, "true");
      rootNavigatorKey.currentState!.context.go(AppRoutes.home);
    } else {
      showToast(message: "some error occured");
    }
  }

  bool _isSigning = false;

  bool get isSigning => _isSigning;

  loading(bool val) {
    _isSigning = val;

    notifyListeners();
  }

  signInWithGoogle() async {
    loading(true);
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      Log.print(googleSignInAccount.toString(), other: "1");

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        Log.print(googleSignInAuthentication.toString(), other: "2");

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        // rootNavigatorKey.currentState!.context.go(AppRoutes.home);

        return await _firebaseAuth.signInWithCredential(credential);
      }
      loading(false);
    } catch (e) {
      showToast(message: "some error occured $e");
      loading(false);
    }
  }
}
