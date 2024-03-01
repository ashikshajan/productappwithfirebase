import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:techware_machinetest/utils/Utils.dart';

import 'package:techware_machinetest/utils/app_routes.dart';

import 'package:techware_machinetest/view_model/login/loginPageVM.dart';

import '../../utils/form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageVM? loginpageController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loginpageController = Provider.of<LoginPageVM>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormWidget(
                controller: loginpageController?.emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormWidget(
                controller: loginpageController?.passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<LoginPageVM>(
                  builder: (context, loginpageController, child) {
                return loginpageController.isSigning == true
                    ? CircularProgressIndicator(
                        color: AppUtil.appprimaryclr,
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              loginpageController.signIn(
                                  loginpageController.emailController.text,
                                  loginpageController.passwordController.text);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: AppUtil.appprimaryclr,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // GestureDetector(
                          //   onTap: () {
                          //     loginpageController.signInWithGoogle();
                          //   },
                          //   child: Container(
                          //     width: double.infinity,
                          //     height: 45,
                          //     decoration: BoxDecoration(
                          //       color: AppUtil.appbtnclr,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Center(
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Icon(
                          //             FontAwesomeIcons.google,
                          //             color: AppUtil.appprimaryclr,
                          //           ),
                          //           const SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(
                          //             " Sign in with Google",
                          //             style: TextStyle(
                          //               color: AppUtil.appprimaryclr,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(AppRoutes.signup);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppUtil.appprimaryclr,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
