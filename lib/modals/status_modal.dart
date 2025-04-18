import 'package:flutter/material.dart';

class StatusModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool closable;

  const StatusModal({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.closable = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: closable
          ? [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              )
            ]
          : null,
    );
  }
}
