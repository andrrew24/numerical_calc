import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

class MethodButton extends StatelessWidget {
  const MethodButton({
    super.key,
    required this.text,
    required this.onpressed,
  });
  final String text;
  final void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 40, vertical: 25)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          backgroundColor: const MaterialStatePropertyAll(primarybtnColor)),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
