import 'package:flutter/material.dart';
import 'package:zavisaft_flutter_task/core/common_widgets/custom_text.dart';

import '../../domain/entities/product.dart';
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                color: Colors.grey.shade50,
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.orange),
                      );
                    },
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 40),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: product.title,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                    fontSize: 12, height: 1.3),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text:"\$${product.price.toStringAsFixed(2)}",

                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.add_shopping_cart,
                            size: 16, color: Colors.orange),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}