import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/app_colors.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
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
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
