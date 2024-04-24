import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants/assets.dart';
import 'widgets/bg.dart';
import 'widgets/method_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBG(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 105,
          horizontal: 75,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MethodButton(
                  text: "Lu Decomposition with Pivoting",
                  onpressed: () {
                    GoRouter.of(context).go('/ludecom');
                  },
                ),
                MethodButton(
                  text: "Gauss Elimination with Pivoting",
                  onpressed: () {
                    GoRouter.of(context).go('/gauss');
                  },
                ),
                MethodButton(
                  text: "Cramer’s Rule",
                  onpressed: () {
                    GoRouter.of(context).go('/cramers');
                  },
                ),
                MethodButton(
                  text: "Secant",
                  onpressed: () {
                    GoRouter.of(context).go('/secant');
                  },
                ),
              ],
            ),
            Image.asset(Assets.imgComputerImg),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MethodButton(
                  text: "Biesection",
                  onpressed: () {
                    GoRouter.of(context).go('/biesect');
                  },
                ),
                MethodButton(
                  text: "False Position",
                  onpressed: () {
                    GoRouter.of(context).go('/falsepos');
                  },
                ),
                MethodButton(
                  text: "Simple Fixed Point",
                  onpressed: () {
                    GoRouter.of(context).go('/simplefixed');
                  },
                ),
                MethodButton(
                  text: "Newton",
                  onpressed: () {
                    GoRouter.of(context).go('/newton');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
