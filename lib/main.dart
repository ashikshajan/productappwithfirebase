import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:techware_machinetest/utils/Utils.dart';
import 'package:techware_machinetest/utils/app_routes.dart';
import 'package:techware_machinetest/view/pages/home_page.dart';
import 'package:techware_machinetest/view/pages/login_page.dart';

import 'package:techware_machinetest/view/pages/sign_up_page.dart';
import 'package:techware_machinetest/view/splash.dart';
import 'package:techware_machinetest/view_model/home/homePageVM.dart';

import 'package:techware_machinetest/view_model/login/loginPageVM.dart';
import 'package:techware_machinetest/view_model/signup/signupVM.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

class RouterTransitionFactory {
  static CustomTransitionPage getTransitionPage(
      {required BuildContext context,
      required GoRouterState state,
      required Widget child,
      required String type}) {
    return CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          switch (type) {
            case 'fade':
              return FadeTransition(opacity: animation, child: child);
            case 'rotation':
              return RotationTransition(turns: animation, child: child);
            case 'size':
              return SizeTransition(sizeFactor: animation, child: child);
            case 'scale':
              return ScaleTransition(scale: animation, child: child);
            default:
              return FadeTransition(opacity: animation, child: child);
          }
        });
  }
}

final GoRouter _router = GoRouter(
  initialLocation: AppRoutes.splash,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
        pageBuilder: (context, state) {
          return RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const SplashScreen(),
            type: 'fade',
          );
        }),
    GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) {
          return const SignUpPage();
        },
        pageBuilder: (context, state) {
          return RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const SignUpPage(),
            type: 'fade',
          );
        }),
    GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const LoginPage();
        },
        pageBuilder: (context, state) {
          return RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const LoginPage(),
            type: 'fade',
          );
        }),
    GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          return const HomePage();
        },
        pageBuilder: (context, state) {
          return RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const HomePage(),
            type: 'fade',
          );
        }),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginPageVM>(create: (_) => LoginPageVM()),
        ChangeNotifierProvider<HomePageVM>(create: (_) => HomePageVM()),
        ChangeNotifierProvider<SignUpPageVM>(create: (_) => SignUpPageVM()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: AppUtil.appprimaryclr,
        routerConfig: _router,
        builder: (context, child) {
          final data = MediaQuery.of(context);

          return MediaQuery(
              data: data.copyWith(textScaler: const TextScaler.linear(0.8)),
              child: child!);
        },
      ),
    );
  }
}
