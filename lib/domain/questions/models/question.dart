abstract class Question {
  final int id;
  final String title;
  final bool isRequired;
  Question({
    required this.title,
    required this.id,
    required this.isRequired,
  });
}
