import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_button.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/modules/community/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:intl/intl.dart';

class MainItemComponent extends ConsumerWidget {
  const MainItemComponent({
    required this.communityModel,
    Key? key,
  }) : super(key: key);

  final CommunityModel communityModel;

  @override
  Widget build(BuildContext context, ref) {
    // final mainCoreVM = ref.watch(mainCoreViewModel.notifier);
    final num avg = communityModel.shares! / communityModel.members!;
    NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadius(context)),
        ),
        color: Colors.transparent,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: AppColors.lightBlack, // <-- Button color
                      onPrimary: Colors.white, // <-- Splash color
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.rocket,
                      size: Sizes.iconsSizes(context)['s5'],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomText.h0(
                    context,
                    numberFormat.format(communityModel.shares),
                    weight: FontStyles.fontWeightMedium,
                    maxLines: 2,
                  ),
                  CustomText.h5(
                    context,
                    'Shares Direct Registered',
                    weight: FontStyles.fontWeightMedium,
                    maxLines: 2,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 50),
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        CustomText.h2(
                          context,
                          numberFormat.format(avg),
                          weight: FontStyles.fontWeightMedium,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                        CustomText.h5(
                          context,
                          'Avg. DRS',
                          weight: FontStyles.fontWeightMedium,
                          color: AppColors.grey,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 20,
                    color: AppColors.grey,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText.h2(
                          context,
                          NumberFormat.compact().format(communityModel.members),
                          weight: FontStyles.fontWeightMedium,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                        CustomText.h5(
                          context,
                          'Members',
                          weight: FontStyles.fontWeightMedium,
                          color: AppColors.grey,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 20,
                    color: AppColors.grey,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomText.h2(
                          context,
                          numberFormat.format(communityModel.nonMembers),
                          weight: FontStyles.fontWeightMedium,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                        CustomText.h5(
                          context,
                          'Applications',
                          weight: FontStyles.fontWeightMedium,
                          color: AppColors.grey,
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 100),
            CustomButton(
              text: tr(context).joinDiscord,
              buttonColor: AppColors.darkThemePrimary,
              width: Sizes.roundedButtonHighWidth(context),
              onPressed: () async {
                // DiscordModel? discord = await _mainVM.generateDiscordInvite();
                // if (discord != null) {
                //   debugPrint("discord invite: ${discord.invite}");
                //   NavigationService.navigateTo(
                //     isNamed: true,
                //     page: RoutePaths.webViewPage,
                //     navigationMethod: NavigationMethod.push,
                //     arguments: {
                //       'url': discord.invite!,
                //       'title': 'Discord Invite'
                //     },
                //   );
                // } else {
                //   CustomSnackBar.showCommonRawSnackBar(context,
                //       snackPosition: SnackPosition.BOTTOM,
                //       margin: const EdgeInsets.symmetric(
                //         horizontal: 0,
                //       ),
                //       description:
                //           'Oops, something went wrong getting your invite. Please try again later.',
                //       color: AppColors.primaryColor,
                //       backgroundGradient: AppColors.primaryErrorIngredientColor,
                //       borderRadius: 2);
                // }
              },
            ),
          ],
        ));
  }
}
