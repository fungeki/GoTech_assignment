part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> questions;
  QuestionsLoaded(this.questions);
}

class QuestionsError extends QuestionsState {}

abstract class QuestionsStateDialog extends QuestionsState {}

class QuestionsStateSubmitDialog extends QuestionsStateDialog {}
