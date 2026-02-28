import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14.0,
    this.height = 1.4,
    this.maxLine = 6,
    this.color =const Color(0xFF06131C),
    // this.color = blackColor,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextAlign textAlign;
  final int maxLine;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final String? fontFamily;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      style: GoogleFonts.montserrat(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,

        decoration: decoration,
        fontStyle: fontStyle,
      ),
    );
  }
}
