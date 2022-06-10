import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/modules/community/components/posts/post_form_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommunityPostScreen extends HookConsumerWidget {
  const CommunityPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return PopUpPage(body: Column(children: const [PostFormComponent()]));
  }
}
