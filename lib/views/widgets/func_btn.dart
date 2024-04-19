import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FuncButton extends StatelessWidget {
  const FuncButton({
    super.key,
    required this.text,
    required this.onpressed,
    required this.btnColor,
  });
  final String text;
  final Color btnColor;
  final void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 30, vertical: 16)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStatePropertyAll(btnColor)),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
