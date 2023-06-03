import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/open_question.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';

class QuestionnaireOpenQuestionCard extends StatelessWidget {
  const QuestionnaireOpenQuestionCard(
      {Key? key, required this.question, required this.onChanged})
      : super(key: key);
  final OpenQuestion question;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    log(question.toString());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              question.title,
              style: AppTextStyles.questionTextStyle,
            ),
            if (question.isRequired)
              Text(
                " *",
                style: AppTextStyles.requiredTextStyle,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: onChanged,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: question.hint,
                      hintStyle: AppTextStyles.questionTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
