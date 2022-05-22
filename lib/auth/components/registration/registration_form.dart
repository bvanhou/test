import 'dart:async';

import 'package:deliverzler/auth/components/registration/registration_text_fields_section.dart';
import 'package:deliverzler/auth/viewmodels/auth_provider.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/app_themes/cupertino_custom_theme.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/utils/dialogs.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// Checkbox Terms and Conditions
class AgreeToTermsAndConditions extends StateNotifier<bool> {
  AgreeToTermsAndConditions() : super(false);
  set value(bool index) => state = index;
}

final agreeToTermsAndConditionProvider =
    StateNotifierProvider((ref) => AgreeToTermsAndConditions());

// Check UserName State Notifier
class UsernameChecker extends StateNotifier<bool> {
  UsernameChecker() : super(false);
  set value(bool index) => state = index;
}

final usernameCheckerProvier =
    StateNotifierProvider((ref) => UsernameChecker());

class DecorationState extends StateNotifier<BorderState> {
  DecorationState() : super(BorderState.base);
  set value(BorderState index) => state = index;
}

final decorationStateProvider =
    StateNotifierProvider((ref) => DecorationState());

class RegistrationFormComponent extends HookConsumerWidget {
  const RegistrationFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final _emailController = useTextEditingController(text: '');
    final _passwordController = useTextEditingController(text: '');
    final _usernameController = useTextEditingController(text: '');

    final _usernameExists = ref.watch(usernameCheckerProvier) as bool;
    final _decorationState = ref.watch(decorationStateProvider) as BorderState;
    final _agreeToTermsAndConditions =
        ref.watch(agreeToTermsAndConditionProvider) as bool;

    Timer? _debounce;

    _usernameController.addListener(() async {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      ref.read(decorationStateProvider.notifier).value = BorderState.focused;
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        // do something with query
        if (_usernameController.value.text.isNotEmpty) {
          bool exists = await ref
              .watch(authProvider.notifier)
              .checkUsernameExists(_usernameController.value.text);
          ref.read(usernameCheckerProvier.notifier).value = exists;
          ref.read(decorationStateProvider.notifier).value =
              !exists ? BorderState.valid : BorderState.error;
        }
      });
    });

    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          RegistrationTextFieldsSection(
            emailController: _emailController,
            passwordController: _passwordController,
            usernameController: _usernameController,
            usernameExists: _usernameExists,
            decorationState: _decorationState,
            onFieldSubmitted: (value) {
              if (_loginFormKey.currentState!.validate() &&
                  _agreeToTermsAndConditions &&
                  !_usernameExists) {
                ref.read(authProvider.notifier).createUserWithEmailAndPassword(
                    context,
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text);
              } else {
                AppDialogs.showErrorDialog(
                  NavigationService.context,
                  message: tr(context).pleaseCompleteForm,
                );
              }
            },
          ),
          SizedBox(height: Sizes.hMarginSmall(context)),
          Row(
            children: [
              Theme(
                  data: ThemeData(
                      unselectedWidgetColor:
                          AppColors.darkThemeTextFieldTextColor),
                  child: Checkbox(
                    value: _agreeToTermsAndConditions,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    tristate: false,
                    activeColor: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (value) {
                      ref
                          .read(agreeToTermsAndConditionProvider.notifier)
                          .value = value!;
                    },
                  )),
              CustomText.h5(
                context,
                tr(context).readAndAccept,
                color: AppColors.grayWhite,
                alignment: Alignment.topLeft,
                weight: FontStyles.fontWeightNormal,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                maxLines: 2,
              ),
              CustomTextButton(
                padding: EdgeInsets.only(
                  left: Sizes.hPaddingTiny(context),
                ),
                elevation: 1,
                minWidth: Sizes.textButtonMinWidth(context),
                minHeight: Sizes.textButtonMinHeight(context),
                buttonColor: Colors.transparent,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () async {
                  Uri url = Uri.parse(const String.fromEnvironment(
                      'APPLICATION_TERMS_AND_CONDITIONS_LINK'));
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                  // NavigationService.navigateTo(
                  //   isNamed: true,
                  //   page: RoutePaths.webViewPage,
                  //   navigationMethod: NavigationMethod.push,
                  //   arguments: {
                  //     'url':
                  //         "https://app.termly.io/document/terms-of-use-for-saas/2f1bbe68-c9db-4577-ba34-752e89bac9ef",
                  //     'title': 'Terms and Conditions'
                  //   },
                  // );
                },
                child: CustomText.h5(
                  context,
                  tr(context).termsAndConditions,
                  color: AppColors.accentColor,
                  alignment: Alignment.center,
                  weight: FontStyles.fontWeightMedium,
                ),
              )
            ],
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Consumer(
            builder: (context, ref, child) {
              final _authLoading = ref.watch(
                authProvider.select((state) =>
                    state.maybeWhen(loading: () => true, orElse: () => false)),
              );
              return _authLoading
                  ? LoadingIndicators.instance.smallLoadingAnimation(
                      context,
                      width: Sizes.loadingAnimationButton(context),
                      height: Sizes.loadingAnimationButton(context),
                    )
                  : CustomButton(
                      text: tr(context).createAccount,
                      onPressed: () {
                        if (_loginFormKey.currentState!.validate() &&
                            _agreeToTermsAndConditions &&
                            !_usernameExists) {
                          ref
                              .watch(authProvider.notifier)
                              .createUserWithEmailAndPassword(context,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  username: _usernameController.text);
                        } else {
                          AppDialogs.showErrorDialog(
                            NavigationService.context,
                            message: tr(context).pleaseCompleteForm,
                          );
                        }
                      },
                    );
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          CustomTextButton(
            elevation: 1,
            minWidth: Sizes.textButtonMinWidth(context),
            minHeight: Sizes.textButtonMinHeight(context),
            buttonColor: Colors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () async {
              NavigationService.pushReplacementAll(
                context,
                isNamed: true,
                page: RoutePaths.authLogin,
              );
            },
            child: CustomText.h5(
              context,
              tr(context).cancel,
              color: AppColors.accentColor,
              weight: FontStyles.fontWeightSemiBold,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }
}
