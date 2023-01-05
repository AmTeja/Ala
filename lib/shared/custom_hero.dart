import 'package:flutter/material.dart';

class CustomHeroWrapper extends StatelessWidget {
  const CustomHeroWrapper({super.key, required this.child, required this.tag});

  final Widget child;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
