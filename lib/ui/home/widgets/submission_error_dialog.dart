import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';

class SubmissionErrorDialog extends StatelessWidget {
  const SubmissionErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Error submitting form",
        style: AppTextStyles.pageHeadline,
      ),
      content: const Text(
        "Please fill in all the required questions before submitting the form",
        style: AppTextStyles.questionTextStyle,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Woops, on it"))
      ],
    );
  }
}
