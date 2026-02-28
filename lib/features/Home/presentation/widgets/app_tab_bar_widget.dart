import 'package:flutter/material.dart';
class AppTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const AppTabBar({super.key, required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orange,
      indicatorWeight: 3,
      labelStyle:
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      tabs: tabs.map((t) => Tab(text: t)).toList(),
    );
  }
}