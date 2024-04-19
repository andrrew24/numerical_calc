import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class AppBG extends StatelessWidget {
  const AppBG({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBGcolor,
      body: child,
    );
  }
}
