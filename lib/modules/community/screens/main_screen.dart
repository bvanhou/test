import 'package:deliverzler/core/screens/popup_page_nested.dart';
import 'package:deliverzler/modules/community/components/main_community_component.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final _locationServiceProvider = ref.watch(locationServiceProvider);
    return const PopUpPageNested(
      body: MainCommunityComponent(),
    );
  }
}
