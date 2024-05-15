class Question {
  final String subject;
  final String statement;
  final List<String> answers;
  late bool itsCorrect;

  Question({
    required this.subject,
    required this.statement,
    required this.answers,
    //required this.itsCorrect
  });
}
