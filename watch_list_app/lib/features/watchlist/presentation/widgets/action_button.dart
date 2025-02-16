import 'package:flutter/material.dart';

enum ElevatedButtonState {
  active,
  disable,
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonState = ElevatedButtonState.disable,
    this.backgroundColor,
    this.labelColor,
    this.width,
    this.borderColor,
  });

  final ElevatedButtonState buttonState;
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? labelColor;
  final double? width;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              (ElevatedButtonState.active == buttonState
                  ? colorScheme.primary
                  : colorScheme.inversePrimary),
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: labelColor ?? colorScheme.onPrimary),
        ),
      ),
    );
  }
}
