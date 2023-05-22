/// An implementation of [Exception] to be used for adding common properties for failures.
abstract class Failure implements Exception {
  Failure(this.message);

  final String? message;
}
