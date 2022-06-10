import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/viewmodels/app_locale_provider.dart';
import 'package:deliverzler/core/viewmodels/app_theme_provider.dart';
import 'package:deliverzler/core/widgets/custom_tile_component.dart';
import 'package:deliverzler/general/settings/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/general/settings/components/settings_section_component.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSettingsSectionComponent extends HookConsumerWidget {
  const AppSettingsSectionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _selectedLanguage = ref.watch(appLocaleProvider);
    final _isDarkThemeMode = ref.watch(appThemeProvider) == ThemeMode.dark;

    return SettingsSectionComponent(
      headerIcon: Icons.settings,
      headerTitle: tr(context).appSettings,
      tileList: [
        CustomTileComponent(
          title: tr(context).theme,
          leadingIcon: !_isDarkThemeMode ? Icons.wb_sunny : Icons.nights_stay,
          customTrailing: Container(
            constraints: BoxConstraints(
              maxWidth: Sizes.switchThemeButtonWidth(context),
            ),
            child: PlatformSwitch(
              value: !_isDarkThemeMode,
              onChanged: (value) {
                ref
                    .watch(appThemeProvider.notifier)
                    .changeTheme(isLight: value);
              },
              material: (_, __) {
                return MaterialSwitchData(
                  activeColor: AppColors.white,
                  activeTrackColor: AppColors.darkThemePrimary,
                );
              },
              cupertino: (_, __) {
                return CupertinoSwitchData(
                  activeColor: AppColors.darkThemePrimary,
                );
              },
            ),
          ),
        ),
        CustomTileComponent(
          title: tr(context).language,
          leadingIcon: Icons.translate,
          trailingText: getCurrentLanguageName(
            context,
            _selectedLanguage?.languageCode,
          ),
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsLanguage,
            );
          },
        ),
        // CustomTileComponent(
        //   title: tr(context).privacy,
        //   leadingIcon: Icons.privacy_tip,
        //   customTrailing: OutlinedButton(
        //     onPressed: null,
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.all(AppColors.grayWhite),
        //       backgroundColor:
        //           MaterialStateProperty.all(AppColors.tertiaryColor),
        //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(30.0))),
        //     ),
        //     child: const Text("Actions Needed"),
        //   ),
        //   onTap: () {
        //     // NavigationService.push(
        //     //   context,
        //     //   isNamed: true,
        //     //   page: RoutePaths.settingsLanguage,
        //     // );
        //   },
        // ),

        CustomTileComponent(
          title: tr(context).help,
          leadingIcon: Icons.question_mark,
          onTap: () {
            NavigationService.push(
              context,
              isNamed: true,
              page: RoutePaths.settingsLanguage,
            );
          },
        ),
      ],
    );
  }
}
