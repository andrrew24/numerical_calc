import 'dart:io';

import 'package:flutter/material.dart';
import 'package:numerical_calc/utils/app_router.dart';
import 'package:window_manager/window_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1500, 700));
    WindowManager.instance.setMaximumSize(const Size(1920, 1080));
  }
  runApp(const NumericalCal());
}

class NumericalCal extends StatelessWidget {
  const NumericalCal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
