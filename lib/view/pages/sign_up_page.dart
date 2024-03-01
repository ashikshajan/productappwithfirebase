import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:techware_machinetest/utils/Utils.dart';

import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/utils/form_widget.dart';

import 'package:techware_machinetest/view_model/signup/signupVM.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpPageVM? signUppageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      signUppageController = Provider.of<SignUpPageVM>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Consumer<SignUpPageVM>(
              builder: (context, signUppageController, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormWidget(
                  controller: signUppageController.usernameController,
                  hintText: "Username",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormWidget(
                  controller: signUppageController.emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormWidget(
                  controller: signUppageController.passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    signUppageController.signUp(
                        signUppageController.emailController.text,
                        signUppageController.passwordController.text);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppUtil.appprimaryclr,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: signUppageController.isSigning == true
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.go(AppRoutes.login);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: AppUtil.appprimaryclr,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
