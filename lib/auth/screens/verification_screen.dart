import 'package:deliverzler/auth/components/app_form_header_component.dart';
import 'package:deliverzler/auth/components/app_logo_component.dart';
import 'package:deliverzler/auth/components/verification/verification_form_component.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerificationScreen extends HookConsumerWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _verificationScaffoldKey =
        useMemoized(() => GlobalKey<ScaffoldState>());

    return PopUpPage(
      scaffoldKey: _verificationScaffoldKey,
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
            mainAxisSize: MainAxisSize.max,
            children: [
              const AppLogoComponent(),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              AppFormHeaderComponent(
                title: tr(context).accountVerification,
                subTitle: tr(context).otpVerification,
              ),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              const VerificationFormComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
