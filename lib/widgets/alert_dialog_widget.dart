import 'package:bloc_printer_thermal/widgets/button.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Button.filled(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: 'OK',
        ),
      ],
    );
  }
}
