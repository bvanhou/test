import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static showCommonRawSnackBar(
    BuildContext context, {
    String? title,
    String description = '',
    Gradient? backgroundGradient,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    Icon? icon,
    Duration duration = const Duration(seconds: 4),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    bool isDismissible = true,
    DismissDirection dismissDirection = DismissDirection.up,
    Function? onTap,
  }) {
    Get.rawSnackbar(
      titleText: (title != null)
          ? CustomText.h4(
              context,
              title,
              weight: FontStyles.fontWeightMedium,
              color: color ?? AppColors.lightBlack,
            )
          : null,
      icon: icon ??
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.white,
            size: Sizes.iconsSizes(context)['s4'],
          ),
      messageText: CustomText.h5(
        context,
        description,
        color: color ?? AppColors.lightBlack,
        weight: FontStyles.fontWeightMedium,
      ),
      backgroundGradient:
          backgroundGradient ?? AppColors.primaryErrorIngredientColor,
      borderRadius: borderRadius ?? Sizes.snackBarRadius(context),
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Sizes.vPaddingSmall(context),
            horizontal: Sizes.hPaddingMedium(context),
          ),
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: Sizes.hMarginComment(context),
          ),
      duration: duration,
      snackPosition: snackPosition,
      dismissDirection: dismissDirection,
      isDismissible: isDismissible,
      onTap: (data) {},
    );
  }
}
