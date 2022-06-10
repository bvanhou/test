import 'package:deliverzler/modules/community/components/posts/post_options_section.dart';
import 'package:deliverzler/modules/community/components/posts/post_text_fields_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final inputTypeProvider = StateProvider.autoDispose<String>((ref) => "init");

class PostFormComponent extends HookConsumerWidget {
  const PostFormComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _postFormKey = useMemoized(() => GlobalKey<FormState>());
    final _titleController = useTextEditingController(text: '');
    final _detailsController = useTextEditingController(text: '');

    return Form(
        key: _postFormKey,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              PostTextFieldsSection(
                titleController: _titleController,
                detailsController: _detailsController,
                onFieldSubmitted: (value) {
                  if (_postFormKey.currentState!.validate()) {
                    // ref.read(authProvider.notifier).signInWithEmailAndPassword(
                    //       context,
                    //       email: _emailController.text,
                    //       password: _passwordController.text,
                    //     );
                  }
                },
              ),
            ],
          ),
          const PostOptionsSection()
        ]));
  }
}
