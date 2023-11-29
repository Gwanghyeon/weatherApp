import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errMsg) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CupertinoAlertDialog(
      title: Text('Error'),
      content: Text(errMsg),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
