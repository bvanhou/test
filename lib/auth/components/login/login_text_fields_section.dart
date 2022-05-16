import 'package:deliverzler/core/styles/app_themes/cupertino_custom_theme.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/utils/validators.dart';
import 'package:deliverzler/core/widgets/custom_text_field.dart';

class LoginTextFieldsSection extends StatelessWidget {
  const LoginTextFieldsSection({
    required this.emailController,
    required this.passwordController,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      material: (_, __) {
        return Column(
          children: _sharedItemComponent(context),
        );
      },
      cupertino: (_, __) {
        return Column(
          children: [
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return CupertinoFormSection(
                  decoration: CupertinoCustomTheme
                      .cupertinoFormSectionReactiveDecoration(context,
                          hasFocus ? borderState.focused : borderState.base),
                  backgroundColor: Colors.transparent,
                  margin: EdgeInsets.zero,
                  children: [
                    CustomTextField(
                      context,
                      controller: emailController,
                      validator: Validators.instance.validateEmail,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: Icon(PlatformIcons(context).mail),
                      hintText: tr(context).email,
                      key: const ValueKey('login_email'),
                    ),
                  ]);
            })),
            SizedBox(height: Sizes.textFieldVMarginDefault(context)),
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return CupertinoFormSection(
                decoration:
                    CupertinoCustomTheme.cupertinoFormSectionReactiveDecoration(
                        context,
                        hasFocus ? borderState.focused : borderState.base),
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                children: [
                  CustomTextField(
                    context,
                    controller: passwordController,
                    validator: Validators.instance.validateLoginPassword,
                    textInputAction: TextInputAction.go,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.password),
                    hintText: tr(context).password,
                    key: const ValueKey('login_password'),
                    onFieldSubmitted: onFieldSubmitted,
                  ),
                ],
              );
            })),
          ],
        );
      },
    );
  }

  _sharedItemComponent(BuildContext context) {
    return [
      CustomTextField(
        context,
        controller: emailController,
        validator: Validators.instance.validateEmail,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        suffixIcon: Icon(PlatformIcons(context).mail),
        hintText: tr(context).email,
        key: const ValueKey('login_email'),
      ),
      CustomTextField(
        context,
        controller: passwordController,
        validator: Validators.instance.validateLoginPassword,
        textInputAction: TextInputAction.go,
        obscureText: true,
        suffixIcon: const Icon(Icons.password),
        hintText: tr(context).password,
        key: const ValueKey('login_password'),
        onFieldSubmitted: onFieldSubmitted,
      ),
    ];
  }
}
