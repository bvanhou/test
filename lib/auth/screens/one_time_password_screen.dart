import 'package:deliverzler/auth/components/app_form_header_component.dart';
import 'package:deliverzler/auth/components/app_logo_component.dart';
import 'package:deliverzler/auth/components/one_time_password/one_time_password_form_component.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OneTimePasswordScreen extends ConsumerWidget {
  final PhoneNumber phoneNumber;
  const OneTimePasswordScreen({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return PopUpPage(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.starryNightBackground,
              ),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: Sizes.screenVPaddingHigh(context),
            horizontal: Sizes.screenHPaddingDefault(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLogoComponent(),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              AppFormHeaderComponent(
                title: tr(context).oneTimePassword,
                subTitle: tr(context).oneTimePasswordDescription,
              ),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              OneTimePasswordFormComponent(phoneNumber: phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}
