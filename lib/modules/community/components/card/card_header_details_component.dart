import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardHeaderDetailsComponent extends StatelessWidget {
  final PostModel postModel;

  const CardHeaderDetailsComponent({
    required this.postModel,
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
            CustomText.h6(
              context,
              "u/ProbablyAnNSAPlant",
              weight: FontStyles.fontWeightNormal,
              color: AppColors.darkThemeSmallTextColor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: Sizes.hMarginTiny(context),
            ),
            Container(
              height: Sizes.statusCircleRadiusTiny(context),
              width: Sizes.statusCircleRadiusTiny(context),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkThemeSmallTextColor,
              ),
            ),
            SizedBox(
              width: Sizes.hMarginTiny(context),
            ),
            Expanded(
              child: CustomText.h6(
                context,
                "6h",
                weight: FontStyles.fontWeightNormal,
                color: AppColors.darkThemeSmallTextColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PlatformIconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.ellipsis,
                color: AppColors.darkThemeSmallTextColor,
                size: Sizes.iconsSizes(context)['s7'],
              ),
              padding: EdgeInsets.zero,
              material: (_, __) {
                return MaterialIconButtonData(
                  constraints: const BoxConstraints(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                );
              },
              cupertino: (_, __) {
                return CupertinoIconButtonData(
                  alignment: Alignment.center,
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
