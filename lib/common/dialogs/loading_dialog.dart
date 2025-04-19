import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Row(
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            Gap(20),
            Text("Loading ..."),
          ],
        ),
      ),
    );
  }
}
