import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/answer.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';

class QuestionnaireRadioRow extends StatelessWidget {
  const QuestionnaireRadioRow(
      {Key? key,
      required this.answer,
      required this.onAnswerChosen,
      required this.groupValue})
      : super(key: key);
  final Answer answer;
  final Function(int?, String?) onAnswerChosen;
  final int groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onAnswerChosen.call(answer.id, null),
      child: Row(
        children: [
          buildRadio(),
          buildTitle(),
          if (answer.isOpenedAnswer) Expanded(child: buildTextField()),
        ],
      ),
    );
  }

  Widget buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onTap: () => onAnswerChosen.call(answer.id, null),
        onChanged: (textValue) => onAnswerChosen.call(answer.id, textValue),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      answer.title,
      style: AppTextStyles.questionTextStyle,
    );
  }

  Radio<int> buildRadio() {
    return Radio(
        value: answer.id,
        groupValue: groupValue,
        onChanged: (chosenId) {
          onAnswerChosen.call(chosenId, null);
        });
  }
}
