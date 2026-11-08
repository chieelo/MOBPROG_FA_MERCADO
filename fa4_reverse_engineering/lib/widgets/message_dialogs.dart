import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
      content: Text(message),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.tonal(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  return result ?? false;
}

Future<void> showMessageDialog(
  BuildContext context, {
  required String title,
  required String message,
  String buttonLabel = 'OK',
}) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(ctx).colorScheme.primary,
            ),
      ),
      content: Text(message),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(buttonLabel),
        ),
      ],
    ),
  );
}