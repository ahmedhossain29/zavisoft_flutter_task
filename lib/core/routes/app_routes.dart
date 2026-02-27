import 'package:flutter/material.dart';
import 'package:zavisaft_flutter_task/features/auth/presentation/screen/login_screen.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {

      case RouteNames.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );

      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}