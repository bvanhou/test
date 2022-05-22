import 'package:deliverzler/core/styles/app_images.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MembershipApplicationScreen extends ConsumerWidget {
  const MembershipApplicationScreen({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _membershipApplicationKey =
      GlobalKey<FormState>();
  static final GlobalKey<ScaffoldState> _scaffoldApplicationKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ref) {
    return Form(
      key: _membershipApplicationKey,
      child: Scaffold(
        backgroundColor: const Color(0xFF171617),
        key: _scaffoldApplicationKey,
        body: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.starryNightBackground,
                ),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Sizes.screenVPaddingHigh(context),
              horizontal: Sizes.screenHPaddingDefault(context),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const AppMembershipApplicationHeaderComponent(),
                const Text("hell0"),
                SizedBox(
                  height: Sizes.vMarginHighest(context),
                ),
                // const AppMembershipApplicationFormComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
