import 'package:flutter/material.dart';
import 'package:zavisaft_flutter_task/core/common_widgets/custom_text.dart';
import 'package:zavisaft_flutter_task/core/utils/utils.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child:  Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: 20),
          Utils.horizontalSpace(8.0),
          CustomText(text: "Search products",
              color: Colors.grey, fontSize: 14),
        ],
      ),
    );
  }
}