import 'package:flutter/material.dart';
import 'package:imechano_admin/ui/shared/styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onYesPressed;
  const ConfirmationDialog({
    required this.message,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Confirmation', style: ThemeText.boldText),
      content: Text('Are you sure you want to $message'),
      actions: [
        TextButton(
          onPressed: () {
            print('Tapped Yes in confirmation dialog');
            onYesPressed();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            print('Tapped No in confirmation dialog');
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
