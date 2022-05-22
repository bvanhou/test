import 'package:deliverzler/auth/components/forgot_password/forgot_password_text_fields_section.dart';
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

class ForgotPasswordFormComponent extends HookConsumerWidget {
  const ForgotPasswordFormComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _forgotPasswordFormKey = useMemoized(() => GlobalKey<FormState>());
    final _emailController = useTextEditingController(text: '');
    final _passwordController = useTextEditingController(text: '');

    return Form(
      key: _forgotPasswordFormKey,
      child: Column(
        children: [
          ForgotPasswordTextFieldsSection(
            emailController: _emailController,
            onFieldSubmitted: (value) {
              if (_forgotPasswordFormKey.currentState!.validate()) {
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
                      text: tr(context).sendOneTimePassword,
                      onPressed: () {
                        if (_forgotPasswordFormKey.currentState!.validate()) {
                          ref.watch(authProvider.notifier).forgotPassword(
                                context,
                                email: _emailController.text,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
