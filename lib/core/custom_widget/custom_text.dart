import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int? max;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  const CustomText(
      {super.key,
      required this.text,
      this.max,
      this.color,
      this.fontWeight,
      this.size,
      this.textAlign, this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(
    overflow: textOverflow,
      textAlign: textAlign,
      maxLines: max ?? 1,
      text,
      style: GoogleFonts.inter(
          color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}