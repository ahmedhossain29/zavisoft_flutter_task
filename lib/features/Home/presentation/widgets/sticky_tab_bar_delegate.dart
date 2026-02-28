import 'package:flutter/material.dart';
class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  const StickyTabBarDelegate({required this.height, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.white,
      elevation: shrinkOffset > 0 ? 2 : 0,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant StickyTabBarDelegate old) =>
      old.height != height;
}