part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class QuestionsEventFetchQuestions extends QuestionsEvent {}

class QuestionsEventOnMultiAnswerClick extends QuestionsEvent {
  final int chosenId;
  final MultiAnswerQuestion question;
  final String? text;

  QuestionsEventOnMultiAnswerClick(
      {required this.chosenId, required this.question, this.text});
}

class QuestionsEventOnSubmit extends QuestionsEvent {}
