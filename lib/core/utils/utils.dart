import 'package:flutter/material.dart';

class Utils {

  static Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;

  static Widget verticalSpace(double size) {
    return SizedBox(height: size);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size);
  }

  static double hSize(double size) {
    return size;
  }

  static double vSize(double size) {
    return size;
  }

  static Widget horizontalLine(){
    return Container(
      height: 1,
      width: double.infinity,
      color: const Color(0xFFEEF2F6),
    );
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left, top: top, right: right, bottom: bottom);
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value);
  }

  static double vPadding({double size = 20.0}) {
    return size;
  }

  static double hPadding({double size = 20.0}) {
    return size;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius;
  }

}