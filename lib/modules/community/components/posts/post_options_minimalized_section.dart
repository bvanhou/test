import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostOptionsMinimalizedSection extends StatelessWidget {
  const PostOptionsMinimalizedSection({
    // required this.titleController,
    // required this.detailsController,
    // required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  // final TextEditingController titleController;
  // final TextEditingController detailsController;
  // final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            border: Border.all(
              color: Colors.grey.shade900,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            SizedBox(height: Sizes.hMarginSmall(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CustomText.h6(context, "What Do You Want To Post?")],
            ),
            SizedBox(height: Sizes.hMarginSmall(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _optionComponent(context,
                    icon: FaIcon(
                      FontAwesomeIcons.textHeight,
                      color: AppColors.darkThemeSmallTextColor,
                      size: Sizes.iconsSizes(context)['s6'],
                    ),
                    label: "Text"),
                _optionComponent(context,
                    icon: FaIcon(
                      FontAwesomeIcons.link,
                      color: AppColors.darkThemeSmallTextColor,
                      size: Sizes.iconsSizes(context)['s6'],
                    ),
                    label: "Link"),
                _optionComponent(context,
                    icon: FaIcon(
                      FontAwesomeIcons.image,
                      color: AppColors.darkThemeSmallTextColor,
                      size: Sizes.iconsSizes(context)['s6'],
                    ),
                    label: "Image"),
                _optionComponent(context,
                    icon: FaIcon(
                      FontAwesomeIcons.video,
                      color: AppColors.darkThemeSmallTextColor,
                      size: Sizes.iconsSizes(context)['s6'],
                    ),
                    label: "Video"),
              ],
            )
          ],
        ));
  }

  _optionComponent(BuildContext context,
      {required FaIcon icon, required String label}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.hMarginHigh(context)),
        child: Column(
          children: [
            PlatformIconButton(
              onPressed: () {},
              color: Colors.grey.shade800,
              icon: icon,
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
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.circular(500));
              },
            ),
            CustomText.h6(
              context,
              label,
            )
          ],
        ));
  }
}
