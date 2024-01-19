import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes_name.dart';
import '../widget/splash/splash_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        context.pushReplacementNamed(RoutesName.mainApp);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashWidget();
  }
}
