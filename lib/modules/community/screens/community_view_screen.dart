import 'package:deliverzler/core/screens/popup_page_nested.dart';
import 'package:deliverzler/modules/community/components/community_post_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommunityViewScreen extends HookConsumerWidget {
  const CommunityViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return PopUpPageNested(
        body: Column(children: const [CommunityViewPostComponent()]));
  }
}
