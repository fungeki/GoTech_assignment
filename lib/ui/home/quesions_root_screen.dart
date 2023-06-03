import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotech_flutter_assignment/blocs/questions/questions_bloc.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/multi_answer_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/open_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/question.dart';
import 'package:gotech_flutter_assignment/styles/app_colors.dart';
import 'package:gotech_flutter_assignment/styles/app_text_styles.dart';
import 'package:gotech_flutter_assignment/ui/home/widgets/questionnaire_headline_card.dart';
import 'package:gotech_flutter_assignment/ui/home/widgets/questionnaire_multi_answer_question_card.dart';
import 'package:gotech_flutter_assignment/ui/home/widgets/questionnaire_open_question_card.dart';
import 'package:gotech_flutter_assignment/ui/home/widgets/submission_error_dialog.dart';

class QuestionsRootScreen extends StatelessWidget {
  const QuestionsRootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsBloc, QuestionsState>(
      listenWhen: (previous, current) => current is QuestionsStateDialog,
      buildWhen: (previous, current) => current is! QuestionsStateDialog,
      listener: (context, state) {
        if (state is QuestionsStateSubmitDialog) {
          showDialog<void>(
              context: context,
              builder: (context) => const SubmissionErrorDialog());
        }
      },
      builder: (context, state) {
        final bloc = context.read<QuestionsBloc>();
        switch (state.runtimeType) {
          case QuestionsInitial:
            bloc.add(QuestionsEventFetchQuestions());
            return const Center(
              child: CircularProgressIndicator(),
            );
          case QuestionsError:
            return const Center(
              child: Text(
                "Error, were sorry something went wrong try again later",
                style: AppTextStyles.pageHeadline,
              ),
            );
            break;
        }
        if (state is QuestionsLoaded) {
          final questions = state.questions;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const QuestionnaireHeadlineCard(),
                  buildQuestionListView(questions, bloc),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => bloc.add(QuestionsEventOnSubmit()),
                      child: const Text(
                        "Submit",
                        style: AppTextStyles.buttonTextStyle,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardHeadlineColor),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView buildQuestionListView(List<Question> questions, QuestionsBloc bloc) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          if (question is MultiAnswerQuestion) {
            return QuestionnaireMultiAnswerQuestionCard(
              question: question,
              onTapAnswer: (id, text) => bloc.add(
                QuestionsEventOnMultiAnswerClick(
                    chosenId: id ?? -1, text: text, question: question),
              ),
            );
          } else if (question is OpenQuestion) {
            return QuestionnaireOpenQuestionCard(
              question: question,
              onChanged: (value) {
                question.userAnswer = value;
              },
            );
          } else {
            return Container();
          }
        });
  }
}
