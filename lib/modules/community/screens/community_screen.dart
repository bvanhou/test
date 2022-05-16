import 'package:deliverzler/core/components/main_drawer.dart';
import 'package:deliverzler/core/screens/popup_page.dart';
import 'package:deliverzler/modules/community/components/bottom_nav_bar_component.dart';
import 'package:deliverzler/modules/community/utils/community_nav_screen_appbar.dart';
import 'package:deliverzler/modules/community/utils/community_nav_screens_utils.dart';
import 'package:deliverzler/modules/community/viewmodels/community_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommunityScreen extends HookConsumerWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    //This prevent disposing communityNavRoutesProviders when switching between tabs
    //Also using autoDispose provider is necessary to reset providers when community is popped
    for (final provider in communityNavRoutesProviders) {
      ref.watch(provider.notifier);
    }
    final _currentIndex = ref.watch(communityNavIndexProvider);
    final _currentRoute = ref.watch(communityNavRoutesProviders[_currentIndex]);
    final _scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    return PopUpPage(
      safeAreaNavBar: true,
      onWillPop: () async {
        //This prevent popping the main navigator when pressing mobile's back button
        if (await CommunityNavScreensUtils
            .communityNavScreensKeys[_currentIndex].currentState!
            .maybePop()) {
          return false;
        }
        //This prevent popping when index isn't 1 (Community) & instead will back to community
        if (_currentIndex != 1) {
          ref.watch(communityNavIndexProvider.notifier).state = 1;
          return false;
        }
        return true;
      },
      //Use dynamic shared Appbar to show differently titled AppBars.
      //This avoid using nested scaffolds as it's not recommended by flutter
      appBar: getCommunityNavScreenAppBar(
        context,
        routeName: _currentRoute,
        scaffoldKey: _scaffoldKey,
      ),
      scaffoldKey: _scaffoldKey,
      drawer: MainDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      body: CommunityNavScreensUtils.communityNavScreens(ref)[_currentIndex],
      cupertinoTabChildBuilder: (context, index) {
        return CommunityNavScreensUtils.communityNavScreens(ref)[index];
      },
      bottomNavigationBar: bottomNavBarComponent(
        context,
        currentIndex: _currentIndex,
        itemChanged: (index) {
          ref.watch(communityNavIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
