import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

class LuDecomForm extends StatelessWidget {
  const LuDecomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MethodForm(
      methodName: "Lu Decomposition",
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
