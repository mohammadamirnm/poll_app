import 'answer.dart';

class Question {
  Question({
    this.type,
    String? text,
    bool? required,
    List<Answer>? answers,
  })  : text = text ?? '',
        required = required ?? false,
        answers = answers ?? <Answer>[];

  final String text;
  final PollType? type;
  final bool required;
  final List<Answer> answers;

  Question copyWith({
    PollType? type,
    String? text,
    bool? required,
    List<Answer>? answers,
  }) {
    return Question(
      type: type,
      text: text,
      required: required,
      answers: answers,
    );
  }
}

enum PollType {
  text,
  rating,
  multiple,
}
