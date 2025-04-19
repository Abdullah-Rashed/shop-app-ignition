import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMsg;
  const ErrorDialog({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            size: 42,
          ),
          Gap(6),
          Text("Oops")
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMsg,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
