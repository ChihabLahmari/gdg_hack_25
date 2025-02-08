import 'package:flutter/material.dart';
import 'package:my_template/core/theming/colors.dart';

class MyEventCard extends StatelessWidget {
  final bool isPast;
  final Widget child;

  const MyEventCard({
    super.key,
    required this.isPast,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorsManager.anotherBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
