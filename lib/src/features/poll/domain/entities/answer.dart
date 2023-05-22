import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  Answer({
    this.isChecked = false,
    String? text,
    int? value,
  })  : text = text ?? '',
        value = value ?? 0;

  final String text;
  final int value;
  bool isChecked;

  @override
  List<Object?> get props => <Object>[value];
}
