import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

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
                AppImages.loginBackground,
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
              // const HeaderComponent(
              //     title: "createNewPassword",
              //     description: "createNewPasswordDescription"),
              SizedBox(
                height: Sizes.vMarginHigh(context),
              ),
              // const ResetPasswordFormComponent(),
              CustomTextButton(
                elevation: 1,
                minWidth: Sizes.textButtonMinWidth(context),
                minHeight: Sizes.textButtonMinHeight(context),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                buttonColor: Colors.transparent,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  NavigationService.pushReplacementAll(
                    context,
                    isNamed: true,
                    page: RoutePaths.authRegistration,
                  );
                },
                child: CustomText.h4(
                  context,
                  tr(context).signUp,
                  color: AppColors.accentColor,
                  weight: FontStyles.fontWeightSemiBold,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
