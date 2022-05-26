import 'package:deliverzler/core/screens/popup_page_nested.dart';
import 'package:deliverzler/general/settings/components/logout_component.dart';
import 'package:deliverzler/general/settings/components/settings_sections_components/app_account_status_component.dart';
import 'package:deliverzler/general/settings/components/user_info_component.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/general/settings/components/settings_sections_components/app_settings_section_component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpPageNested(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingDefault(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const UserInfoComponent(),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              const AppAccountStatusSectionComponent(),
              const AppSettingsSectionComponent(),
              SizedBox(
                height: Sizes.vMarginExtreme(context) * 1.5,
              ),
              const LogoutComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
