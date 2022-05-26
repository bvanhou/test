import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:deliverzler/modules/community/components/main_item_component.dart';
import 'package:deliverzler/modules/community/viewmodels/community_service_provider/community_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainCommunityComponent extends ConsumerWidget {
  const MainCommunityComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final mainCommunityStream = ref.watch(mainCommunityStreamProvider);
    return mainCommunityStream.when(
      data: (upcomingOrders) {
        return upcomingOrders.isEmpty
            ? CustomText.h4(
                context,
                tr(context).issueGettingCommunity,
                color: AppColors.grey,
                alignment: Alignment.center,
              )
            : Center(
                child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.screenVPaddingDefault(context),
                  horizontal: Sizes.screenHPaddingMedium(context),
                ),
                itemBuilder: (context, index) {
                  return MainItemComponent(
                    communityModel: upcomingOrders[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Sizes.vMarginHigh(context),
                ),
                itemCount: upcomingOrders.length,
              ));
      },
      error: (err, stack) => CustomText.h4(
        context,
        '${tr(context).somethingWentWrong}\n${tr(context).pleaseTryAgainLater}',
        color: AppColors.grey,
        alignment: Alignment.center,
        textAlign: TextAlign.center,
      ),
      loading: () => LoadingIndicators.instance.smallLoadingAnimation(context),
    );
  }
}
