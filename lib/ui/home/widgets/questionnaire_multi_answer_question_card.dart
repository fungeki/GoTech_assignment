import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/multi_answer_question.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';
import 'package:gotech_flutter_assignment/ui/home/widgets/questionnaire_radio_row.dart';

class QuestionnaireMultiAnswerQuestionCard extends StatelessWidget {
  const QuestionnaireMultiAnswerQuestionCard(
      {Key? key, required this.question, required this.onTapAnswer})
      : super(key: key);

  final MultiAnswerQuestion question;
  final Function(int?, String?) onTapAnswer;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(question.title),
                if (question.isRequired)
                  const Text(
                    " *",
                    style: AppTextStyles.requiredTextStyle,
                  )
              ],
            ),
            ...question.answers
                .map((answer) => QuestionnaireRadioRow(
                    answer: answer,
                    onAnswerChosen: onTapAnswer,
                    groupValue: question.chosenId ?? -1))
                .toList()
          ],
        ),
      ),
    );
  }
}
