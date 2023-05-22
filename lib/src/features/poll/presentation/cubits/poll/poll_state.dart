part of 'poll_cubit.dart';

@freezed
class PollState with _$PollState {
  const factory PollState.initial() = _Initial;
  const factory PollState.loading() = _Loading;
  const factory PollState.error(String message) = _Error;
  const factory PollState.loaded(Poll poll) = _Loaded;
}
