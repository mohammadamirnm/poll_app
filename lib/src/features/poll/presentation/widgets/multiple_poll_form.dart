import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:poll_app/src/common_widgets/dot_indicator.dart';
import 'package:poll_app/src/common_widgets/submit_button.dart';
import 'package:poll_app/src/features/poll/domain/entities/question.dart';

import '../../domain/entities/answer.dart';

class MultiplePollForm extends StatefulWidget {
  const MultiplePollForm({
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
  State<MultiplePollForm> createState() => _MultiplePollFormState();
}

class _MultiplePollFormState extends State<MultiplePollForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(
                widget.question.answers[index].text,
              ),
              trailing: Checkbox(
                value: widget.question.answers[index].isChecked,
                onChanged: (bool? value) => setState(
                  () =>
                      widget.question.answers[index].isChecked = value ?? false,
                ),
              ),
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: widget.question.answers.length,
          ),
        ),
        const SizedBox(height: 36),
        DotIndicator(
          currentIndex: widget.currentIndex,
          count: widget.count,
        ),
        const SizedBox(height: 36),
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
