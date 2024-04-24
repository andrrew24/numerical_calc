import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class MatrixEliment extends StatelessWidget {
  const MatrixEliment({
    super.key,
    required this.eliment,
  });
  final String eliment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: ShapeDecoration(
          color: txtfeldTableColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Center(
        child: Text(
          eliment,
          style: GoogleFonts.montserrat(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
