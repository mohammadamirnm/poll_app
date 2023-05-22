import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_app/src/features/poll/domain/entities/answer.dart';
import 'package:poll_app/src/features/poll/domain/entities/question.dart';
import 'package:poll_app/src/features/poll/presentation/cubits/poll/poll_cubit.dart';
import 'package:poll_app/src/features/poll/presentation/pages/finish_page.dart';
import 'package:poll_app/src/features/poll/presentation/widgets/multiple_poll_form.dart';
import 'package:poll_app/src/features/poll/presentation/widgets/rating_poll_form.dart';
import 'package:poll_app/src/helpers/context_extension.dart';

import '../../domain/entities/poll.dart';
import '../widgets/text_poll_form.dart';

class PollPage extends StatefulWidget {
  const PollPage({
    super.key,
    required this.poll,
    required this.questionNumber,
  });

  final Poll poll;
  final int questionNumber;

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  int get _questionIndex => widget.questionNumber - 1;

  Question get question => widget.poll.questions[_questionIndex];

  void _navigateToNextPage() {
    if (widget.questionNumber == widget.poll.questions.length) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<FinishPage>(
          builder: (BuildContext context) => FinishPage(
            poll: widget.poll,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<PollPage>(
          builder: (BuildContext context) => PollPage(
            poll: widget.poll,
            questionNumber: widget.questionNumber + 1,
          ),
        ),
      );
    }
  }

  Widget get _form {
    switch (question.type) {
      case PollType.multiple:
        return MultiplePollForm(
          currentIndex: _questionIndex,
          count: widget.poll.questions.length,
          question: question,
          onSubmitted: () {
            context
                .read<PollCubit>()
                .addAnsweredQuestion(question, widget.questionNumber);

            _navigateToNextPage();
          },
        );
      case PollType.text:
        return TextPollForm(
          currentIndex: _questionIndex,
          count: widget.poll.questions.length,
          onSubmitted: (String message) {
            final Question answeredQuestion = question
                .copyWith(answers: <Answer>[Answer(value: 0, text: message)]);

            context.read<PollCubit>().addAnsweredQuestion(
                answeredQuestion, widget.questionNumber + 1);

            _navigateToNextPage();
          },
        );
      case PollType.rating:
        return RatingPollForm(
          currentIndex: _questionIndex,
          count: widget.poll.questions.length,
          question: question,
          onSubmitted: () {
            context
                .read<PollCubit>()
                .addAnsweredQuestion(question, widget.questionNumber);

            _navigateToNextPage();
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '${'label_survey'.tr()} ${widget.questionNumber}/${widget.poll.questions.length}',
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.black.withOpacity(0.05),
              height: 1.0,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 48),
              Text(
                question.text,
                style: context.theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              Expanded(child: _form),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
