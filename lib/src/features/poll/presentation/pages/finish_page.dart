import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:poll_app/src/common_widgets/submit_button.dart';
import 'package:poll_app/src/config/colors.dart';
import 'package:poll_app/src/features/poll/domain/entities/poll.dart';
import 'package:poll_app/src/helpers/context_extension.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key, required this.poll});

  final Poll poll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${'label_survey'.tr()} ${'label_completed'.tr()}"),
        centerTitle: true,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.check,
              color: LightThemeColors.checkColorColor,
            ),
          )
        ],
      ),
      body: Column(
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
                  poll.finishText,
                  style: context.theme.textTheme.bodyMedium,
                ),
                const Spacer(),
                SubmitButton(
                  text: 'label_close'.tr(),
                  onPressed: () {
                    //Todo: place code for sending data
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
