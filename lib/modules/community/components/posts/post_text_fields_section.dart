import 'package:deliverzler/core/styles/app_themes/cupertino_custom_theme.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/modules/community/components/posts/post_form_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:deliverzler/core/utils/validators.dart';
import 'package:deliverzler/core/widgets/custom_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostTextFieldsSection extends HookConsumerWidget {
  const PostTextFieldsSection({
    required this.titleController,
    required this.detailsController,
    required this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController detailsController;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context, ref) {
    final _selectedOption = ref.watch(inputTypeProvider);
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
                      .cupertinoFormSectionReactiveDecoration(
                          context, BorderState.none),
                  backgroundColor: Colors.transparent,
                  margin: EdgeInsets.zero,
                  children: [_sharedItemComponent(context)[0]]);
            })),
            // SizedBox(height: Sizes.textFieldVMarginDefault(context)),
            Focus(child: Builder(builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return CupertinoFormSection(
                decoration:
                    CupertinoCustomTheme.cupertinoFormSectionReactiveDecoration(
                        context, BorderState.none),
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                children: [_sharedItemComponent(context)[1]],
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
        controller: titleController,
        validator: Validators.instance.validateEmail,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        // suffixIcon: Icon(PlatformIcons(context).mail),
        hintText: "Add Title",
        key: const ValueKey('post_title'),
      ),
      CustomTextField(
        context,
        controller: detailsController,
        validator: Validators.instance.validateLoginPassword,
        textInputAction: TextInputAction.go,
        obscureText: true,
        // suffixIcon: const Icon(Icons.password),
        hintText: "Add optional body text",
        key: const ValueKey('post_details'),
        onFieldSubmitted: onFieldSubmitted,
        height: Sizes.availableScreenHeight(context) * .9,
        borderRadiusSize: 0,
      ),
    ];
  }

  _hintTextComponent(BuildContext context, ref) {}
}
