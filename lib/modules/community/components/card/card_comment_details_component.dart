import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardCommentDetailsComponent extends StatelessWidget {
  const CardCommentDetailsComponent({
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
              : CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            PlatformIconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.message,
                color: AppColors.darkThemeSmallTextColor,
                size: Sizes.iconsSizes(context)['s7'],
              ),
              padding: EdgeInsets.zero,
              material: (_, __) {
                return MaterialIconButtonData(
                  constraints: const BoxConstraints(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  alignment: Alignment.centerRight,
                );
              },
              cupertino: (_, __) {
                return CupertinoIconButtonData(
                  alignment: Alignment.centerRight,
                );
              },
            ),
            SizedBox(width: Sizes.hMarginTiny(context)),
            CustomText.h6(
              context,
              "100",
              weight: FontStyles.fontWeightNormal,
              color: AppColors.darkThemeSmallTextColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
