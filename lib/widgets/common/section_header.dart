import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onActionPressed;
  final String? actionLabel;
  final IconData? actionIcon;
  final EdgeInsets padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onActionPressed,
    this.actionLabel,
    this.actionIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (onActionPressed != null) ...[
            TextButton(
              onPressed: onActionPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionLabel != null)
                    Text(actionLabel!),
                  if (actionIcon != null) ...[
                    if (actionLabel != null)
                      const SizedBox(width: 4),
                    Icon(actionIcon, size: 18),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
