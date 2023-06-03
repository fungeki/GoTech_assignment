import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/multi_answer_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/open_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/question.dart';
import 'package:gotech_flutter_assignment/repo/sources/questions_server_datasource.dart';
import 'package:meta/meta.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionsServerDatasource dataSource;

  List<Question> questions = [];

  QuestionsBloc(this.dataSource) : super(QuestionsInitial()) {
    on<QuestionsEventFetchQuestions>(questionsEventFetchQuestions);
    on<QuestionsEventOnMultiAnswerClick>(questionsEventOnMultiAnswerClick);
    on<QuestionsEventOnSubmit>(questionsEventOnSubmit);
  }

  FutureOr<void> questionsEventFetchQuestions(
      QuestionsEventFetchQuestions event, Emitter<QuestionsState> emit) async {
    log("attempting to get questions");
    try {
      questions = await dataSource.getQuestions();
      emit(QuestionsLoaded(questions));
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(QuestionsError());
    }
  }

  FutureOr<void> questionsEventOnMultiAnswerClick(
      QuestionsEventOnMultiAnswerClick event, Emitter<QuestionsState> emit) {
    final question = event.question;
    question.chosenId = event.chosenId;
    question.userText = event.text;
    emit(QuestionsLoaded(questions));
  }

  FutureOr<void> questionsEventOnSubmit(
      QuestionsEventOnSubmit event, Emitter<QuestionsState> emit) async {
    final List<Map<String, dynamic>> data = [];
    for (final question in questions) {
      final isRequired = question.isRequired;
      if (question is MultiAnswerQuestion) {
        if (question.chosenId < 0 && isRequired) {
          log("${question.title} error");
          emit(QuestionsStateSubmitDialog());
          return null;
        } else if (question.chosenId >= 0) {
          data.add(question.toMap());
        }
      }
      if (question is OpenQuestion) {
        final didInputAnswer = question.userAnswer != null &&
            question.userAnswer!.trim().isNotEmpty;
        if (!didInputAnswer && isRequired) {
          log("${question.title} error");
          emit(QuestionsStateSubmitDialog());
          return null;
        } else if (didInputAnswer) {
          data.add(question.toMap());
        }
      }
    }
    try {
      await dataSource.sendQuestions(data);
    } catch (error, stackTrace) {
      emit(QuestionsError());
      log(error.toString());
      log(stackTrace.toString());
      return null;
    }
    questions.forEach((question) {
      if (question is MultiAnswerQuestion) {
        question.chosenId = -1;
        question.userText = null;
      }
      if (question is OpenQuestion) {
        question.userAnswer = null;
      }
    });
    emit(QuestionsLoaded(questions));
  }
}
