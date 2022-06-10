import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';

class FeedHeaderComponent extends StatelessWidget {
  const FeedHeaderComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: LocalizationService.instance.isAr(context)
              ? CrossAxisAlignment.baseline
              : CrossAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: const [],
        ),
        CustomText.h2(
          context,
          tr(context).communityFeed,
          color: AppColors.grayWhite,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
