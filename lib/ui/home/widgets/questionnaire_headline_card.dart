import 'package:flutter/material.dart';
import 'package:gotech_flutter_assignment/styles/app_colors.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';

class QuestionnaireHeadlineCard extends StatelessWidget {
  const QuestionnaireHeadlineCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = "GoTech Questionnaire";
    const subtitle = "show me what you got!";
    const footer = "* Required";
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.cardHeadlineColor,
              width: 8,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: AppTextStyles.pageHeadline,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                subtitle,
                style: AppTextStyles.questionTextStyle,
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                footer,
                style: AppTextStyles.requiredTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
