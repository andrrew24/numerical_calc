import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

class BiesectionForm extends StatelessWidget {
  const BiesectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MethodForm(
      methodName: "BieSection",
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
