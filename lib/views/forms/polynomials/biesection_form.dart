import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerical_calc/utils/constants/app_colors.dart';
import 'package:numerical_calc/views/widgets/methods_form.dart';

import '../../../main_methods/biesect.dart';

class BiesectionForm extends StatefulWidget {
  const BiesectionForm({super.key});

  @override
  State<BiesectionForm> createState() => _BiesectionFormState();
}

class _BiesectionFormState extends State<BiesectionForm> {
  late Biesection biesection =
      Biesection(eps: 0, xL: 0, xU: 0, expressionString: '');

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
      biesection.iterations = [];
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
        biesection =
            Biesection(eps: error, xL: xl, xU: xu, expressionString: eq);
        biesection.biesection();
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
        methodName: "BieSection",
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
                ? Container(
                    decoration: ShapeDecoration(
                        color: txtfeldTableColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    height: MediaQuery.sizeOf(context).height * 0.6,
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
                      rows: biesection.iterations
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.iter.toStringAsFixed(0),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.xl.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.fxl.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.xu.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.fxu.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.xr.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text(e.fxr.toStringAsFixed(3),
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                                DataCell(Text("${e.error.toStringAsFixed(2)} %",
                                    style: GoogleFonts.montserrat(
                                        textStyle:
                                            const TextStyle(fontSize: 15)))),
                              ]))
                          .toList(),
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.width,
  });

  final TextEditingController controller;
  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        const Gap(15),
        SizedBox(
          width: width,
          child: TextField(
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(fontSize: 15)),
            controller: controller,
            decoration: const InputDecoration(
                filled: true,
                fillColor: txtfeldTableColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
          ),
        ),
      ],
    );
  }
}


// Container(
//         color: Colors.amber,
//         height: 300,
//         child: Column(
//           children: biesection.iterations
//               .map((e) => Text(
//                   "iter: ${e.iter.toStringAsFixed(3)} |xl: ${e.xl.toStringAsFixed(3)}| f(xl): ${e.fxl.toStringAsFixed(3)}|xu: ${e.xu.toStringAsFixed(3)}|f(xu): ${e.fxu.toStringAsFixed(3)}|xr: ${e.xr.toStringAsFixed(3)}|f(xr): ${e.fxr.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}"))
//               .toList(),
//         ),
//       ),


// Biesection(
//       eps: 1, xL: 0, xU: 1, expressionString: "4 * x^3 - 6 * x^2 + 7*x - 2.3");



//working table
// DataTable(
//                         border: TableBorder.all(color: Colors.white),
//                         columns: const [
//                           DataColumn(label: Text("iter")),
//                           DataColumn(label: Text("Xl")),
//                           DataColumn(label: Text("f(Xl)")),
//                           DataColumn(label: Text("Xu")),
//                           DataColumn(label: Text("f(Xu)")),
//                           DataColumn(label: Text("Xr")),
//                           DataColumn(label: Text("f(Xr)")),
//                           DataColumn(label: Text("error")),
//                         ],
//                         rows: biesection.iterations
//                             .map((e) => DataRow(cells: [
//                                   DataCell(Text(e.iter.toStringAsFixed(0))),
//                                   DataCell(Text(e.xl.toStringAsFixed(3))),
//                                   DataCell(Text(e.fxl.toStringAsFixed(3))),
//                                   DataCell(Text(e.xu.toStringAsFixed(3))),
//                                   DataCell(Text(e.fxu.toStringAsFixed(3))),
//                                   DataCell(Text(e.xr.toStringAsFixed(3))),
//                                   DataCell(Text(e.fxr.toStringAsFixed(3))),
//                                   DataCell(
//                                       Text("${e.error.toStringAsFixed(2)} %")),
//                                 ]))
//                             .toList(),
//                       ),