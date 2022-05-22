import 'package:deliverzler/auth/components/login/login_text_fields_section.dart';
import 'package:deliverzler/auth/viewmodels/auth_provider.dart';
import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginFormComponent extends HookConsumerWidget {
  const LoginFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _loginFormKey = useMemoized(() => GlobalKey<FormState>());
    final _emailController = useTextEditingController(text: '');
    final _passwordController = useTextEditingController(text: '');

    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          LoginTextFieldsSection(
            emailController: _emailController,
            passwordController: _passwordController,
            onFieldSubmitted: (value) {
              if (_loginFormKey.currentState!.validate()) {
                ref.read(authProvider.notifier).signInWithEmailAndPassword(
                      context,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
              }
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                    page: RoutePaths.authForgotPassword,
                  );
                },
                child: CustomText.h5(
                  context,
                  tr(context).forgotPassword,
                  color: AppColors.accentColor,
                  weight: FontStyles.fontWeightSemiBold,
                  alignment: Alignment.center,
                ),
              ),
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
                      text: tr(context).logIn,
                      onPressed: () {
                        if (_loginFormKey.currentState!.validate()) {
                          ref
                              .watch(authProvider.notifier)
                              .signInWithEmailAndPassword(
                                context,
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                    );
            },
          ),
          SizedBox(
            height: Sizes.vMarginSmall(context),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText.h5(
                context,
                tr(context).dontHaveAnAccount,
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
              SizedBox(
                width: Sizes.hMarginSmall(context),
              ),
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
                child: CustomText.h5(
                  context,
                  tr(context).signUp,
                  color: AppColors.accentColor,
                  weight: FontStyles.fontWeightSemiBold,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
