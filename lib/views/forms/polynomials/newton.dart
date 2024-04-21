import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerical_calc/math/polynomials/newton.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_input_feild.dart';

class NewtonForm extends StatefulWidget {
  const NewtonForm({super.key});

  @override
  State<NewtonForm> createState() => _NewtonFormState();
}

class _NewtonFormState extends State<NewtonForm> {
  late Newton newton = Newton(eps: 0, x: 0, expressionString: "");

  final TextEditingController eqcontroller = TextEditingController();
  final TextEditingController errorcontroller = TextEditingController();
  final TextEditingController xocontroller = TextEditingController();

  bool isAcive = false;

  late double xo;
  late double error;
  late String eq;

  static List<String> tableheader = [
    "Iter",
    "Xi",
    "f(Xi)",
    "fdash(Xi)",
    "Error%"
  ];

  reset() {
    setState(() {
      newton.iterations = [];
      xocontroller.clear();
      errorcontroller.clear();
      eqcontroller.clear();
      isAcive = false;
    });
  }

  solve() {
    setState(() {
      try {
        error = double.parse(errorcontroller.text);
        xo = double.parse(xocontroller.text);
        eq = eqcontroller.text;
        newton = Newton(eps: error, x: xo, expressionString: eq);
        newton.newton();
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
      methodName: "Newton",
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
                label: "Xo",
                controller: xocontroller,
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
                                      textStyle: const TextStyle(fontSize: 15)),
                                )))
                            .toList(),
                        rows: newton.iterations
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e.iter.toStringAsFixed(0),
                                      style: GoogleFonts.montserrat(
                                          textStyle:
                                              const TextStyle(fontSize: 15)))),
                                  DataCell(Text(e.xi.toStringAsFixed(3),
                                      style: GoogleFonts.montserrat(
                                          textStyle:
                                              const TextStyle(fontSize: 15)))),
                                  DataCell(Text(e.fxi.toStringAsFixed(3),
                                      style: GoogleFonts.montserrat(
                                          textStyle:
                                              const TextStyle(fontSize: 15)))),
                                  DataCell(Text(e.fdashxi.toStringAsFixed(3),
                                      style: GoogleFonts.montserrat(
                                          textStyle:
                                              const TextStyle(fontSize: 15)))),
                                  DataCell(Text(
                                      "${e.error.toStringAsFixed(2)} %",
                                      style: GoogleFonts.montserrat(
                                          textStyle:
                                              const TextStyle(fontSize: 15)))),
                                ]))
                            .toList(),
                      ),
                    ),
                    const Gap(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Root: ${newton.iterations.last.xi.toStringAsFixed(3)}",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 15, color: Colors.white)),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
