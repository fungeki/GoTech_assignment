import 'package:gotech_flutter_assignment/domain/questions/models/answer.dart';
import 'package:gotech_flutter_assignment/domain/questions/models/question.dart';

class MultiAnswerQuestion extends Question {
  final List<Answer> answers;
  int chosenId = -1;
  String? userText;
  MultiAnswerQuestion(
      {required super.title,
      required super.id,
      required super.isRequired,
      required this.answers});

  @override
  String toString() {
    return 'MultiAnswerQuestion{answers: $answers, chosenId: $chosenId, userText: $userText}';
  }

  factory MultiAnswerQuestion.fromMap(Map<String, dynamic> json) {
    final answersJson = json["answers"] as List;
    final List<Answer> answers = answersJson
        .map((json) => Answer.fromJson(json as Map<String, dynamic>))
        .toList();
    return MultiAnswerQuestion(
        id: json["id"] as int,
        title: json["title"] as String? ?? "",
        isRequired: json["isRequired"] as bool,
        answers: answers);
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "chosenId": chosenId, "userText": userText};
  }
}
