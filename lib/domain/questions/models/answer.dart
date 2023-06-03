class Answer {
  final int id;
  final String title;
  final bool isOpenedAnswer;

  Answer({
    required this.id,
    required this.title,
    required this.isOpenedAnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
      id: json["id"] as int,
      title: json["title"] as String,
      isOpenedAnswer: json["isMultiAnswer"] == true ? true : false);
}
