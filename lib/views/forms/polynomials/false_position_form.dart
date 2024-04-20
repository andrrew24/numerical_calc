import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerical_calc/math/polynomials/false_position.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_input_feild.dart';

class FalsePositionForm extends StatefulWidget {
  const FalsePositionForm({super.key});

  @override
  State<FalsePositionForm> createState() => _FalsePositionFormState();
}

class _FalsePositionFormState extends State<FalsePositionForm> {
  late FalsePosition falsePosition =
      FalsePosition(eps: 0, xL: 0, xU: 0, expressionString: '');

  final TextEditingController eqcontroller = TextEditingController();
  final TextEditingController xlcontroller = TextEditingController();
  final TextEditingController xucontroller = TextEditingController();
  final TextEditingController errorcontroller = TextEditingController();

  bool isAcive = false;

  late double error;
  late double xl;
  late double xu;
  late String eq;

  static List<String> tableheader = [
    "Iter",
    "Xl",
    "f(Xl)",
    "Xu",
    "f(Xu)",
    "Xr",
    "f(Xr)",
    "Error%"
  ];

  reset() {
    setState(() {
      falsePosition.iterations = [];
      xlcontroller.clear();
      xucontroller.clear();
      errorcontroller.clear();
      eqcontroller.clear();
      isAcive = false;
    });
  }

  solve() {
    setState(() {
      try {
        error = double.parse(errorcontroller.text);
        xl = double.parse(xlcontroller.text);
        xu = double.parse(xucontroller.text);
        eq = eqcontroller.text;
        falsePosition =
            FalsePosition(eps: error, xL: xl, xU: xu, expressionString: eq);
        falsePosition.falseposition();
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
      methodName: "False Position",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputField(
                  label: "F(X)",
                  controller: eqcontroller,
                  width: 500,
                ),
                const Gap(103),
                CustomInputField(
                  label: "Xl",
                  controller: xlcontroller,
                  width: 90,
                ),
                const Gap(103),
                CustomInputField(
                  label: "Xu",
                  controller: xucontroller,
                  width: 90,
                ),
                const Gap(103),
                CustomInputField(
                  label: "E%",
                  controller: errorcontroller,
                  width: 90,
                ),
              ],
            ),
            const Gap(30),
            isAcive
                ? Column(
                    children: [
                      Container(
                        decoration: ShapeDecoration(
                            color: txtfeldTableColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: DataTable2(
                          scrollController: ScrollController(),
                          columns: tableheader
                              .map((e) => DataColumn(
                                      label: Text(
                                    e,
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)),
                                  )))
                              .toList(),
                          rows: falsePosition.iterations
                              .map((e) => DataRow(cells: [
                                    DataCell(Text(e.iter.toStringAsFixed(0),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.xl.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.fxl.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.xu.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.fxu.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.xr.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(e.fxr.toStringAsFixed(3),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                    DataCell(Text(
                                        "${e.error.toStringAsFixed(2)} %",
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15)))),
                                  ]))
                              .toList(),
                        ),
                      ),
                      const Gap(20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Root: ${falsePosition.iterations.last.xr.toStringAsFixed(3)}",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 15, color: Colors.white)),
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        )
    );
  }
}
