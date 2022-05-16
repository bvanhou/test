import 'package:deliverzler/auth/components/app_form_header_component.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/auth/components/app_logo_component.dart';
import 'package:deliverzler/auth/components/login/login_form_component.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/core/styles/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: tr(context).logIn,
                subTitle: tr(context).welcomeBack,
              ),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              const LoginFormComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
