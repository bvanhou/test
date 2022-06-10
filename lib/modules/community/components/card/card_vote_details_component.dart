import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardVoteDetailsComponent extends StatelessWidget {
  const CardVoteDetailsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        PlatformIconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.circleUp,
            color: AppColors.darkThemeSmallTextColor,
            size: Sizes.iconsSizes(context)['s7'],
          ),
          padding: const EdgeInsets.all(0),
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
              minSize: 0,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
            );
          },
        ),
        SizedBox(width: Sizes.hMarginTiny(context)),
        CustomText.h6(
          context,
          "5690",
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          weight: FontStyles.fontWeightNormal,
          color: AppColors.darkThemeSmallTextColor,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: Sizes.hMarginTiny(context)),
        PlatformIconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.circleDown,
            color: AppColors.darkThemeSmallTextColor,
            size: Sizes.iconsSizes(context)['s7'],
          ),
          padding: EdgeInsets.zero,
          material: (_, __) {
            return MaterialIconButtonData(
                constraints: const BoxConstraints(),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                alignment: Alignment.centerLeft);
          },
          cupertino: (_, __) {
            return CupertinoIconButtonData(
              minSize: 0,
              alignment: Alignment.centerLeft,
            );
          },
        ),
      ],
    );
  }
}
