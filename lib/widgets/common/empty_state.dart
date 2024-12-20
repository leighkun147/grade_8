import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? onActionPressed;
  final String? actionLabel;
  final double spacing;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.onActionPressed,
    this.actionLabel,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
            SizedBox(height: spacing),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              SizedBox(height: spacing / 2),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onActionPressed != null && actionLabel != null) ...[
              SizedBox(height: spacing),
              ElevatedButton(
                onPressed: onActionPressed,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
