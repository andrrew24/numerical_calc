import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerical_calc/utils/constants/app_colors.dart';
import 'package:numerical_calc/views/widgets/bg.dart';
import 'package:numerical_calc/views/widgets/func_btn.dart';

class MethodForm extends StatelessWidget {
  const MethodForm(
      {super.key,
      required this.content,
      required this.methodName,
      required this.backOnpressed,
      required this.resetOnpressed,
      required this.solveOnpressed});

  final Widget content;
  final String methodName;
  final void Function() backOnpressed;
  final void Function() resetOnpressed;
  final void Function() solveOnpressed;

  @override
  Widget build(BuildContext context) {
    return AppBG(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                methodName,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              const Gap(50),
              content,
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FuncButton(
                    text: "Back",
                    onpressed: backOnpressed,
                    btnColor: backbtnColor,
                  ),
                  Row(
                    children: [
                      FuncButton(
                          text: "Reset",
                          onpressed: resetOnpressed,
                          btnColor: resetbtnColor),
                      const Gap(15),
                      FuncButton(
                          text: "Solve",
                          onpressed: solveOnpressed,
                          btnColor: solvebtnColor),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
