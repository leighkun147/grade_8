import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final bool selected;
  final bool outlined;

  const CustomChip({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
    this.selected = false,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final backgroundColor = color ??
        (selected
            ? colorScheme.primary
            : outlined
                ? Colors.transparent
                : colorScheme.surface);

    final borderColor = color ??
        (selected
            ? Colors.transparent
            : outlined
                ? colorScheme.primary
                : Colors.transparent);

    final textColor = selected
        ? colorScheme.onPrimary
        : outlined
            ? colorScheme.primary
            : colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: outlined ? 1.5 : 0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: textColor,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: selected ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
