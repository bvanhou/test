import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/widgets/custom_image.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';

class AppFormHeaderComponent extends StatelessWidget {
  final bool icon;
  final String title;
  final String? subTitle;
  const AppFormHeaderComponent(
      {Key? key, this.icon = false, required this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (title.isNotEmpty)
              CustomText.h2(
                context,
                title,
                color: AppColors.darkThemeBigTextColor,
                textAlign: TextAlign.start,
              ),
            if (icon)
              CustomImage.s3(
                context,
                AppImages.hiHand,
                padding: EdgeInsets.only(bottom: Sizes.vPaddingTiny(context)),
              ),
          ],
        ),
        SizedBox(
          height: Sizes.vMarginSmall(context),
        ),
        if (subTitle != null && subTitle!.isNotEmpty)
          CustomText.h5(
            context,
            subTitle ?? tr(context).welcomeBack,
            color: AppColors.grey,
            weight: FontStyles.fontWeightMedium,
          ),
      ],
    );
  }
}
