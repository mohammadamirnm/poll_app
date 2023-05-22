import 'package:flutter/material.dart';
import 'package:poll_app/src/config/colors.dart';
import 'package:poll_app/src/helpers/context_extension.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  final int currentIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index
                ? context.theme.colorScheme.primary
                : LightThemeColors.dotIndicatorInactiveColor,
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: count,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
