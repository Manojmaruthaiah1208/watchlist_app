import 'package:flutter/material.dart';
import '../../../../core/constants/widget_sizes.dart';

class VerticalScrollBar extends StatelessWidget {
  const VerticalScrollBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: WidgetSizes.s51,
        height: WidgetSizes.s5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
