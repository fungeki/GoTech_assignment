import 'dart:convert';
import 'dart:developer';

import 'package:gotech_flutter_assignment/domain/questions/enums.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/multi_answer_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/open_question.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/question.dart';
import 'package:gotech_flutter_assignment/services/network.dart';

class QuestionsServerDatasource {
  final NetworkManager networkManager;

  static const _root = "http://localhost:3000";
  static const questionsUrl = "$_root/questions";
  static const sendAnswers = "$_root/answers";

  Future<List<Question>> getQuestions() async {
    final List<Question> questions = [];
    try {
      final response =
          await networkManager.request(RequestMethod.get, questionsUrl);
      final data = response.data as List;
      questions.clear();
      for (final question in data) {
        final json = question as Map<String, dynamic>;
        final type = json["type"] as int;
        final questionType = QuestionType.values[type];
        switch (questionType) {
          case QuestionType.multiAnswers:
            questions.add(MultiAnswerQuestion.fromMap(json));
            break;
          case QuestionType.openQuestion:
            questions.add(OpenQuestion.fromMap(json));
            break;
        }
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
    }
    return questions;
  }

  Future sendQuestions(final List<Map<String, dynamic>> data) async {
    final resultJson = json.encode(data);
    await networkManager.request(RequestMethod.post, sendAnswers,
        data: resultJson, headers: {"Content-Type": "application/json"});
  }

  QuestionsServerDatasource(this.networkManager);
}
