import 'question.dart';

class Poll {
  Poll({
    String? title,
    String? description,
    String? imageUrl,
    String? termsAndConditionsUrl,
    String? finishText,
    List<Question>? questions,
  })  : title = title ?? '',
        description = description ?? '',
        imageUrl = imageUrl ?? '',
        termsAndConditionsUrl = termsAndConditionsUrl ?? '',
        finishText = finishText ?? '',
        questions = questions ?? <Question>[];

  final String title;
  final String description;
  final String imageUrl;
  final String termsAndConditionsUrl;
  final String finishText;
  final List<Question> questions;
}
