import 'package:flutter/material.dart';
import 'app_bottom_navigation_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  final Widget child;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
      ),
    );
  }
}
