import 'package:flutter/material.dart';

class LayoutManager extends StatelessWidget {
  const LayoutManager({
    Key? key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  }) : super(key: key);

  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 480) {
          // Mobile Version
          return mobileLayout;
        } else if (constraints.maxWidth <= 1024) {
          // Tablet Version
          return tabletLayout;
        } else {
          // Desktop Version
          return desktopLayout;
        }
      },
    );
  }
}
