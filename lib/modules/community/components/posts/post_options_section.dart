import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/modules/community/components/posts/post_form_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostOptionsSection extends HookConsumerWidget {
  const PostOptionsSection({
    // required this.titleController,
    // required this.detailsController,
    // required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  // final TextEditingController titleController;
  // final TextEditingController detailsController;
  // final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context, ref) {
    bool _keyboardIsVisible() {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }

    return _keyboardIsVisible()
        ? Positioned(
            bottom: _keyboardIsVisible()
                ? MediaQuery.of(context).viewInsets.bottom - 15
                : 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  border: Border.all(
                    color: Colors.grey.shade900,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Sizes.hMarginSmallest(context)),
                  _tTFont(context),
                  SizedBox(width: Sizes.hMarginSmallest(context)),
                  CustomText.h4(
                    context,
                    "Text",
                    weight: FontStyles.fontWeightBold,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  SizedBox(width: Sizes.hMarginSmallest(context)),
                  FaIcon(
                    FontAwesomeIcons.angleDown,
                    size: Sizes.iconsSizes(context)['s7'],
                    color: AppColors.grey,
                  ),
                ],
              ),
            ))
        : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                      children: [
                        CustomText.h6(context, "What Do You Want To Post?")
                      ],
                    ),
                    SizedBox(height: Sizes.hMarginSmall(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _optionComponent(context, ref,
                            icon: FaIcon(
                              FontAwesomeIcons.t,
                              color: AppColors.darkThemeSmallTextColor,
                              size: Sizes.iconsSizes(context)['s8'],
                            ),
                            icon2: FaIcon(
                              FontAwesomeIcons.t,
                              color: AppColors.darkThemeSmallTextColor,
                              semanticLabel: "largeT",
                              size: Sizes.iconsSizes(context)['s5'],
                            ),
                            label: "Text"),
                        _optionComponent(context, ref,
                            icon: FaIcon(
                              FontAwesomeIcons.link,
                              color: AppColors.darkThemeSmallTextColor,
                              size: Sizes.iconsSizes(context)['s6'],
                            ),
                            label: "Link"),
                        _optionComponent(context, ref,
                            icon: FaIcon(
                              FontAwesomeIcons.image,
                              color: AppColors.darkThemeSmallTextColor,
                              size: Sizes.iconsSizes(context)['s6'],
                            ),
                            label: "Image"),
                        _optionComponent(context, ref,
                            icon: FaIcon(
                              FontAwesomeIcons.video,
                              color: AppColors.darkThemeSmallTextColor,
                              size: Sizes.iconsSizes(context)['s6'],
                            ),
                            label: "Video"),
                      ],
                    )
                  ],
                )));
  }

  _optionComponent(BuildContext context, ref,
      {required FaIcon icon, FaIcon? icon2, required String label}) {
    final _selectedOption = ref.watch(inputTypeProvider);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.hMarginHigh(context)),
        child: Column(
          children: [
            Row(children: [
              PlatformIconButton(
                onPressed: () {
                  ref.watch(inputTypeProvider.notifier).state = label;
                },
                color: _selectedOption == label
                    ? AppColors.darkThemePrimary
                    : Colors.grey.shade800,
                icon: (icon2 != null) ? _tTFont(context) : icon,
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
            ]),
            CustomText.h6(
              context,
              label,
              weight: FontStyles.fontWeightSemiBold,
              color: _selectedOption == label
                  ? AppColors.darkThemePrimary
                  : AppColors.grayWhite,
            )
          ],
        ));
  }

  _tTFont(BuildContext context) {
    return Row(children: [
      FaIcon(FontAwesomeIcons.t,
          size: Sizes.iconsSizes(context)['s8'], color: AppColors.grayWhite),
      FaIcon(
        FontAwesomeIcons.t,
        size: Sizes.iconsSizes(context)['s6'],
        color: AppColors.grayWhite,
      ),
    ]);
  }
}
