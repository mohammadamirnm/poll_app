import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:poll_app/src/common_widgets/dot_indicator.dart';
import 'package:poll_app/src/common_widgets/submit_button.dart';

class TextPollForm extends StatefulWidget {
  const TextPollForm({
    super.key,
    this.onSubmitted,
    required this.currentIndex,
    required this.count,
  });

  final void Function(String message)? onSubmitted;
  final int currentIndex;
  final int count;

  @override
  State<TextPollForm> createState() => _TextPollFormState();
}

class _TextPollFormState extends State<TextPollForm> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: TextField(
            onChanged: (String value) => setState(() {
              _message = value;
            }),
            minLines: 3,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
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
          onPressed: _message.isEmpty
              ? null
              : () => widget.onSubmitted?.call(_message),
        )
      ],
    );
  }
}
