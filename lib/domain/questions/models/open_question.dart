import 'package:gotech_flutter_assignment/domain/questions/models/question.dart';

class OpenQuestion extends Question {
  final String hint;
  String? userAnswer;

  OpenQuestion({
    required super.title,
    required super.id,
    required this.hint,
    this.userAnswer,
    required super.isRequired,
  });

  @override
  String toString() {
    return 'OpenQuestion{hint: $hint, userAnswer: $userAnswer}';
  }

  factory OpenQuestion.fromMap(Map<String, dynamic> json) => OpenQuestion(
      title: json["title"] as String,
      id: json["id"] as int,
      hint: json["hint"] as String,
      isRequired: json["isRequired"] as bool);

  Map<String, dynamic> toMap() {
    return {"id": id, "userAnswer": userAnswer?.trim()};
  }
}
