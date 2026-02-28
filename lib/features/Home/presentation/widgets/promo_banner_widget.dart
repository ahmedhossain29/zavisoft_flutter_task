import 'package:flutter/material.dart';
import 'package:zavisaft_flutter_task/core/common_widgets/custom_text.dart';

import '../../../../core/utils/utils.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade300, Colors.deepOrange.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "⚡ Flash Sale",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            Utils.verticalSpace(8.0),
            CustomText(
              text: "Up to 50% off today only!",
              fontSize: 16,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
