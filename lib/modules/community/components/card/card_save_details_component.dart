import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardSaveDetailsComponent extends StatelessWidget {
  const CardSaveDetailsComponent({
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
                FontAwesomeIcons.bookmark,
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
            ),
          ],
        ),
      ],
    );
  }
}
