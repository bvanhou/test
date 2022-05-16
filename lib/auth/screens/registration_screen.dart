import 'package:deliverzler/auth/components/app_form_header_component.dart';
import 'package:deliverzler/auth/components/app_logo_component.dart';
import 'package:deliverzler/auth/components/registration/registration_form.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static final GlobalKey<ScaffoldState> _registrationScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ref) {
    return PopUpPage(
        body: Scaffold(
      key: _registrationScaffoldKey,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLogoComponent(),
              AppFormHeaderComponent(
                title: tr(context).register,
                subTitle: tr(context).joinTheCommunity,
              ),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              const RegistrationFormComponent(),
            ],
          ),
        ),
      ),
    ));
  }
}
