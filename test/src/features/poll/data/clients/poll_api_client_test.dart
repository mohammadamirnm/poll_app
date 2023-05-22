import 'package:flutter_test/flutter_test.dart';
import 'package:poll_app/src/features/poll/data/clients/poll_api_client.dart';
import 'package:poll_app/src/features/poll/data/models/poll_model.dart';
import 'package:poll_app/src/features/poll/data/repositories/poll_repository.dart';
import 'package:poll_app/src/features/poll/domain/entities/poll.dart';

class MockPollApiClient extends Fake implements PollApiClient {
  static const String mockQuestionText = 'mockQuestionText';

  @override
  Future<PollModel> getPollModel() async {
    final PollModel mockPollModels = PollModel(
      questions: <QuestionModel>[
        QuestionModel(text: mockQuestionText),
      ],
    );
    return mockPollModels;
  }
}

void main() {
  group('Poll Repository Test', () {
    late final PollRepository pollRepository;
    late final MockPollApiClient mockPollApiClient;

    setUp(() {
      mockPollApiClient = MockPollApiClient();
      pollRepository = PollRepository(pollApiClient: mockPollApiClient);
    });

    test('Poll Repository shows the correct data for calling getPoll ',
        () async {
      final Poll poll = await pollRepository.getPoll();

      expect(poll.questions.first.text, MockPollApiClient.mockQuestionText);
    });
  });
}
