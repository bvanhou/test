import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/core/widgets/loading_indicators.dart';
import 'package:deliverzler/modules/community/components/card/card_item_component.dart';
import 'package:deliverzler/modules/community/viewmodels/posts_service_provider/posts_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String mainCommunity = "GcufeauRxASa9oSGVoNf";

class CommunityViewPostComponent extends ConsumerWidget {
  const CommunityViewPostComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final postStream = ref.watch(communityPostStreamProvider(mainCommunity));
    return postStream.when(
      data: (posts) {
        return posts.isEmpty
            ? CustomText.h4(
                context,
                tr(context).issueGettingCommunityPosts,
                color: AppColors.grey,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.screenHPaddingMedium(context),
                ),
              )
            : Column(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.screenHPaddingMedium(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: DropdownButton<String>(
                              value: 'Hot posts',
                              underline: Container(),
                              items: <String>[
                                'Hot posts',
                                'Best posts',
                                'Top posts',
                                'New posts'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                        ],
                      )),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes.screenVPaddingDefault(context),
                      horizontal: Sizes.screenHPaddingMedium(context),
                    ),
                    itemBuilder: (context, index) {
                      return CardItemComponent(
                        postModel: posts[index],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Sizes.vMarginHigh(context),
                    ),
                    itemCount: posts.length,
                  )
                ],
              );
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
