import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_tile_component.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/general/settings/components/settings_section_component.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppAccountStatusSectionComponent extends ConsumerWidget {
  const AppAccountStatusSectionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final _selectedLanguage = ref.watch(appLocaleProvider);
    // final _isDarkThemeMode = ref.watch(appThemeProvider) == ThemeMode.dark;

    return SettingsSectionComponent(
      headerIcon: Icons.settings,
      headerTitle: tr(context).accountStatus,
      tileList: [
        CustomTileComponent(
          title: tr(context).theme,
          isPill: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes.hPaddingHighest(context) * 2),
          // leadingIcon: !_isDarkThemeMode ? Icons.wb_sunny : Icons.nights_stay,
        )
      ],
    );
  }
}
