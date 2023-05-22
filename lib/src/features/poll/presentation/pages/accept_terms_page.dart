import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_app/src/common_widgets/submit_button.dart';
import 'package:poll_app/src/features/poll/presentation/cubits/poll/poll_cubit.dart';
import 'package:poll_app/src/features/poll/presentation/pages/poll_page.dart';
import 'package:poll_app/src/helpers/context_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/poll.dart';

class AcceptTermsPage extends StatefulWidget {
  const AcceptTermsPage({super.key});

  @override
  State<AcceptTermsPage> createState() => _AcceptTermsPageState();
}

class _AcceptTermsPageState extends State<AcceptTermsPage> {
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    context.read<PollCubit>().getPoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('label_survey'.tr()),
        centerTitle: true,
      ),
      body: BlocBuilder<PollCubit, PollState>(
        builder: (BuildContext context, PollState state) => state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          initial: () => const Center(child: CircularProgressIndicator()),
          error: (String message) => Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 32),
                Text(message),
                TextButton(
                  onPressed: () => context.read<PollCubit>().getPoll(),
                  child: Text('label_retry'.tr()),
                ),
              ],
            ),
          ),
          loaded: (Poll poll) => Column(
            children: <Widget>[
              Image.network(
                poll.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Center(child: Text('label_no_image'.tr())),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        poll.title,
                        style: context.theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        poll.description,
                        style: context.theme.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _termsAccepted,
                            onChanged: (bool? value) => setState(() {
                              _termsAccepted = value ?? false;
                            }),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'label_terms_accept'.tr(),
                                    style: context.theme.textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                      text: 'label_terms_and_conditions'.tr(),
                                      style: context.theme.textTheme.bodySmall
                                          ?.copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          final Uri url = Uri.parse(
                                              poll.termsAndConditionsUrl);

                                          if (!await launchUrl(url)) {
                                            throw Exception(
                                                'Could not launch $url');
                                          }
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SubmitButton(
                        text: 'label_start'.tr(),
                        onPressed: _termsAccepted
                            ? () => Navigator.push(
                                  context,
                                  MaterialPageRoute<PollPage>(
                                    builder: (BuildContext context) => PollPage(
                                      poll: poll,
                                      questionNumber: 1,
                                    ),
                                  ),
                                )
                            : null,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
