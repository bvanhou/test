import 'package:deliverzler/core/components/appbar_with_icon_component.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/services/platform_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_app_bar_widget.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PlatformAppBar? getCommunityNavScreenAppBar(
  context, {
  required String routeName,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  switch (routeName) {
    case RoutePaths.community:
      return CustomAppBar(
        context,
        scaffoldKey: scaffoldKey,
        hasMenuButton: PlatformService.instance.isMaterialApp() ? true : false,
        customTitle: CustomText.h2(
          context,
          tr(context).appName,
          color: AppColors.grayWhite,
          alignment: Alignment.center,
        ),
      );
    case RoutePaths.communityMain:
      return CustomAppBar(
        context,
        scaffoldKey: scaffoldKey,
        hasMenuButton: PlatformService.instance.isMaterialApp() ? true : false,
        customTitle: CustomText.h2(
          context,
          tr(context).appName,
          color: AppColors.grayWhite,
          alignment: Alignment.center,
        ),
      );
    case RoutePaths.communityBoard:
      return CustomAppBar(
        context,
        scaffoldKey: scaffoldKey,
        hasMenuButton: PlatformService.instance.isMaterialApp() ? true : false,
        customTitle: CustomText.h2(
          context,
          tr(context).communityFeed,
          color: AppColors.grayWhite,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.screenHPaddingMedium(context)),
        ),
      );
    case RoutePaths.communityView:
      return CustomAppBar(
        context,
        scaffoldKey: scaffoldKey,
        hasMenuButton: PlatformService.instance.isMaterialApp() ? true : false,
      );
    case RoutePaths.communityPost:
      return CustomAppBar(context,
          scaffoldKey: scaffoldKey,
          hasMenuButton:
              PlatformService.instance.isMaterialApp() ? true : false,
          customLeading: FaIcon(
            FontAwesomeIcons.xmark,
            size: Sizes.iconsSizes(context)['s4'],
          ),
          trailingActions: [
            CustomButton(
              text: tr(context).post,
              height: Sizes.roundedButtonMinHeight(context),
              width: Sizes.roundedButtonMinWidth(context),
              buttonColor: Colors.transparent,
              onPressed: () {},
            ),
          ]);
    case RoutePaths.profile:
      return CustomAppBar(
        context,
        hasBackButton: PlatformService.instance.isMaterialApp() ? true : false,
        customTitle: AppBarWithIconComponent(
          icon: AppImages.profileScreenIcon,
          title: tr(context).myProfile,
        ),
      );
    case RoutePaths.settings:
      return CustomAppBar(
        context,
        hasBackButton: PlatformService.instance.isMaterialApp() ? true : false,
        customTitle: CustomText.h2(
          context,
          tr(context).settings,
          color: AppColors.grayWhite,
          alignment: Alignment.center,
        ),
      );
    case RoutePaths.settingsLanguage:
      return CustomAppBar(
        context,
        hasBackButton: true,
        customTitle: AppBarWithIconComponent(
          icon: AppImages.languageScreenIcon,
          title: tr(context).language,
        ),
      );
    case RoutePaths.settingsProfile:
      return CustomAppBar(
        context,
        hasBackButton: true,
        customTitle: AppBarWithIconComponent(
          icon: AppImages.settingsScreenIcon,
          title: tr(context).myProfile,
        ),
      );
    default:
      return null;
  }
}
