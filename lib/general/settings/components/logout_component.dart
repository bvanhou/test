import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/general/settings/viewmodels/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoutComponent extends ConsumerWidget {
  const LogoutComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _settingsVM = ref.watch(settingsViewModel);

    return PlatformWidget(
      material: (_, __) {
        return InkWell(
          onTap: _settingsVM.signOut,
          child: const _SharedItemComponent(),
        );
      },
      cupertino: (_, __) {
        return GestureDetector(
          onTap: _settingsVM.signOut,
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
      margin: EdgeInsets.symmetric(horizontal: Sizes.hMarginHighest(context)),
      padding: EdgeInsets.symmetric(
        vertical: Sizes.vMarginSmallest(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightThemePrimary,
        borderRadius: BorderRadius.circular(
          Sizes.roundedButtonDefaultRadius(context),
        ),
        border: Border.all(
          width: 1,
          color: AppColors.lightThemePrimary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.logout,
            color: AppColors.darkThemeNormalTextColor,
          ),
          SizedBox(
            width: Sizes.hMarginSmall(context),
          ),
          CustomText.h4(
            context,
            tr(context).logOut,
            alignment: Alignment.center,
            color: AppColors.darkThemeNormalTextColor,
          ),
        ],
      ),
    );
  }
}
