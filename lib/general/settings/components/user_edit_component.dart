import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserEditComponent extends ConsumerWidget {
  const UserEditComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return PlatformWidget(
      material: (_, __) {
        return InkWell(
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsProfile,
            );
          },
          child: const _SharedItemComponent(),
        );
      },
      cupertino: (_, __) {
        return GestureDetector(
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsProfile,
            );
          },
          child: const _SharedItemComponent(),
        );
      },
    );
  }
}

class _SharedItemComponent extends StatelessWidget {
  const _SharedItemComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.vPaddingSmall(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(
          Sizes.dialogSmallRadius(context),
        ),
        border: Border.all(
          width: 1,
          color: AppColors.lightThemePrimary,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).hintColor.withOpacity(0.15),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.logout,
            color: AppColors.grayWhite,
          ),
          SizedBox(
            width: Sizes.hMarginSmall(context),
          ),
          CustomText.h4(
            context,
            tr(context).profileSettings,
            alignment: Alignment.center,
            weight: FontStyles.fontWeightExtraBold,
            color: AppColors.grayWhite,
          ),
        ],
      ),
    );
  }
}

navigationToUserProfileScreen(BuildContext context) {
  NavigationService.pushReplacementAll(
    context,
    isNamed: true,
    page: RoutePaths.community,
  );
}
