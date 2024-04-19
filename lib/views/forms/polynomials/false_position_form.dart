import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

class FalsePositionForm extends StatelessWidget {
  const FalsePositionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MethodForm(
      methodName: "False Position",
      backOnpressed: () {
        GoRouter.of(context).go('/');
      },
      resetOnpressed: () {},
      solveOnpressed: () {},
      content: Container(
        color: Colors.amber,
        height: 300,
      ),
    );
  }
}
