import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/modules/community/components/card/card_content_details_component.dart';
import 'package:deliverzler/modules/community/components/card/card_footer_details_component.dart';
import 'package:deliverzler/modules/community/components/card/card_header_details_component.dart';
import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:deliverzler/core/styles/sizes.dart';

class CardItemComponent extends ConsumerWidget {
  const CardItemComponent({
    required this.postModel,
    Key? key,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context, ref) {
    // final orderDialogsVM = ref.watch(orderDialogsViewModel);
    // final bool _isUpcomingOrder = postModel.orderDeliveryStatus ==
    //     describeEnum(OrderDeliveryStatus.upcoming);

    return Card(
      color: AppColors.darkThemeTextFieldBorderColor,
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.cardRadiusSmall(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.cardVPaddingTiny(context),
          horizontal: Sizes.cardHRadius(context),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CardHeaderDetailsComponent(
                    postModel: postModel,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Sizes.vMarginTiny(context),
            ),
            CardContentDetailsComponent(
              postModel: postModel,
            ),
            SizedBox(
              height: Sizes.vMarginComment(context),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CardFooterDetailsComponent(
                    postModel: postModel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
