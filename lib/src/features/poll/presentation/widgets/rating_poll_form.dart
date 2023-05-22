import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:poll_app/src/common_widgets/dot_indicator.dart';
import 'package:poll_app/src/common_widgets/submit_button.dart';
import 'package:poll_app/src/helpers/context_extension.dart';

import '../../domain/entities/answer.dart';
import '../../domain/entities/question.dart';

class RatingPollForm extends StatefulWidget {
  const RatingPollForm({
    super.key,
    this.onSubmitted,
    required this.question,
    required this.currentIndex,
    required this.count,
  });

  final void Function()? onSubmitted;
  final Question question;

  final int currentIndex;
  final int count;

  @override
  State<RatingPollForm> createState() => _RatingPollFormState();
}

class _RatingPollFormState extends State<RatingPollForm> {
  Answer? _selectedAnswer;

  @override
  void initState() {
    _selectedAnswer = widget.question.answers.firstWhereOrNull(
      (Answer answer) => answer.isChecked,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: List<Widget>.generate(
              widget.question.answers.length,
              (int index) => Expanded(
                child: Column(
                  children: <Widget>[
                    Radio<Answer>(
                      value: widget.question.answers[index],
                      groupValue: _selectedAnswer,
                      onChanged: (Answer? value) {
                        setState(() {
                          if (value == widget.question.answers[index]) {
                            widget.question.answers[index].isChecked = true;
                          } else {
                            widget.question.answers[index].isChecked = false;
                          }
                        });

                        _selectedAnswer = value ?? Answer(value: -1);
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question.answers[index].text,
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        DotIndicator(
          currentIndex: widget.currentIndex,
          count: widget.count,
        ),
        const Spacer(),
        SubmitButton(
          text: 'label_next'.tr(),
          onPressed: widget.question.answers.firstWhereOrNull(
                    (Answer answer) => answer.isChecked,
                  ) !=
                  null
              ? widget.onSubmitted
              : null,
        )
      ],
    );
  }
}
