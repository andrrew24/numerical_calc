import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerical_calc/math/algebric/cramer.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

import '../../widgets/custom_input_feild.dart';
import '../../widgets/matrix_eliment.dart';

class CramersForm extends StatefulWidget {
  const CramersForm({super.key});

  @override
  State<CramersForm> createState() => _CramersFormState();
}

class _CramersFormState extends State<CramersForm> {
  late CramerRule cramerRule = CramerRule(eq1: "", eq2: "", eq3: "");

  final TextEditingController eq1controller = TextEditingController();
  final TextEditingController eq2controller = TextEditingController();
  final TextEditingController eq3controller = TextEditingController();

  bool isAcive = false;

  late String eq1;
  late String eq2;
  late String eq3;

  reset() {
    setState(() {
      cramerRule.coefficients = []; // Matrix
      cramerRule.determinants = []; // A , A1,A2,A3
      cramerRule.solutions = []; // X1, X2 , X3
      eq1controller.clear();
      eq2controller.clear();
      eq3controller.clear();
      isAcive = false;
    });
  }

  solve() {
    setState(() {
      try {
        eq1 = eq1controller.text;
        eq2 = eq2controller.text;
        eq3 = eq3controller.text;
        cramerRule = CramerRule(eq1: eq1, eq2: eq2, eq3: eq3);
        cramerRule.solve();
        isAcive = true;
      } catch (e) {
        reset();
        final snackBar = SnackBar(
            duration: const Duration(seconds: 2),
            clipBehavior: Clip.none,
            elevation: 0,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Error",
              message: "Enter Valid Input",
              contentType: ContentType.warning,
            ));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MethodForm(
        methodName: "Cramer's Rule",
        backOnpressed: () {
          GoRouter.of(context).go('/');
        },
        resetOnpressed: () {
          reset();
        },
        solveOnpressed: () {
          solve();
        },
        content: Column(
          children: [
            Column(
              children: [
                CustomInputField(
                    controller: eq1controller, label: "Eq1", width: 400),
                const Gap(10),
                CustomInputField(
                    controller: eq2controller, label: "Eq2", width: 400),
                const Gap(10),
                CustomInputField(
                    controller: eq3controller, label: "Eq3", width: 400),
              ],
            ),
            const Gap(50),
            isAcive
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "A",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Gap(40),
                          Column(
                            children: cramerRule.coefficients
                                .map((e) => Row(
                                      children: [
                                        Row(
                                          children: e
                                              .map((e) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MatrixEliment(
                                                        eliment:
                                                            e.toStringAsFixed(
                                                                0)),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                          Gap(120),
                          Row(
                            children: [
                              Text(
                                "A",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Gap(40),
                              MatrixEliment(
                                  eliment: cramerRule.dA.toStringAsFixed(0))
                            ],
                          ),
                          Gap(120),
                          Column(
                            children: [
                              Text(
                                "A1",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Gap(30),
                              Text(
                                "A2",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Gap(30),
                              Text(
                                "A3",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Gap(40),
                          Column(
                            children: cramerRule.determinants
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MatrixEliment(
                                          eliment: e.toStringAsFixed(0)),
                                    ))
                                .toList(),
                          ),
                          Gap(120),
                          Column(
                            children: [
                              Text(
                                "X1",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Gap(30),
                              Text(
                                "X2",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Gap(30),
                              Text(
                                "X3",
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const Gap(40),
                          Column(
                            children: cramerRule.solutions
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MatrixEliment(
                                          eliment: e.toStringAsFixed(0)),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox()
          ],
        ));
  }
}
