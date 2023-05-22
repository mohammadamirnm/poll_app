import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:poll_app/src/exceptions/failure.dart';

import '../../../data/repositories/poll_repository.dart';
import '../../../domain/entities/poll.dart';
import '../../../domain/entities/question.dart';

part 'poll_state.dart';
part 'poll_cubit.freezed.dart';

class PollCubit extends Cubit<PollState> {
  PollCubit({
    PollRepository? pollRepository,
  })  : _pollRepository = pollRepository ?? PollRepository(),
        super(const PollState.initial());

  final PollRepository _pollRepository;

  /// These are the questions answered that I would've passed to the api.
  final List<Question> _answeredQuestions = <Question>[];

  void addAnsweredQuestion(Question question, int questionNumber) {
    final int questionIndex = questionNumber - 1;
    if (_answeredQuestions.length > questionNumber) {
      _answeredQuestions.replaceRange(
        questionIndex,
        questionIndex,
        <Question>[question],
      );
    } else {
      _answeredQuestions.add(question);
    }
  }

  Future<void> getPoll() async {
    try {
      emit(const PollState.loading());

      final Poll poll = await _pollRepository.getPoll();

      emit(PollState.loaded(poll));
    } on Failure catch (failure) {
      emit(PollState.error(failure.message ?? ''));
    } catch (e) {
      emit(PollState.error(e.toString()));
    }
  }
}
