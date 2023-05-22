import 'package:poll_app/src/features/poll/data/models/poll_model.dart';
import 'package:poll_app/src/features/poll/domain/entities/answer.dart';
import 'package:poll_app/src/features/poll/domain/entities/poll.dart';
import 'package:poll_app/src/features/poll/domain/entities/question.dart';

import '../clients/poll_api_client.dart';

class PollRepository {
  PollRepository({
    PollApiClient? pollApiClient,
  }) : _pollApiClient = pollApiClient ?? PollApiClient();

  final PollApiClient _pollApiClient;

  Future<Poll> getPoll() async {
    final PollModel pollModel = await _pollApiClient.getPollModel();

    final Poll poll = _pollModelToPoll(pollModel);

    return poll;
  }

  Poll _pollModelToPoll(PollModel pollModel) {
    final Poll poll = Poll(
      description: pollModel.description,
      finishText: pollModel.finishText,
      imageUrl: pollModel.imageUrl,
      questions: pollModel.questions
          ?.map(
            (QuestionModel questionModel) => Question(
              text: questionModel.text,
              type: _typeToPollType(questionModel.type ?? ''),
              required: questionModel.required,
              answers: questionModel.answers
                  ?.map(
                    (AnswerModel answerModel) => Answer(
                      text: answerModel.text,
                      value: answerModel.value,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
      termsAndConditionsUrl: pollModel.termsAndConditionsUrl,
      title: pollModel.title,
    );

    return poll;
  }

  PollType _typeToPollType(String type) {
    switch (type) {
      case 'text':
        return PollType.text;

      case 'multiple':
        return PollType.multiple;

      case 'rating':
        return PollType.rating;

      default:
        return PollType.text;
    }
  }
}
