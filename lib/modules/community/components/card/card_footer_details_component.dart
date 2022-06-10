import 'package:deliverzler/modules/community/components/card/card_comment_details_component.dart';
import 'package:deliverzler/modules/community/components/card/card_save_details_component.dart';
import 'package:deliverzler/modules/community/components/card/card_vote_details_component.dart';
import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:flutter/material.dart';

class CardFooterDetailsComponent extends StatelessWidget {
  final PostModel postModel;

  const CardFooterDetailsComponent({
    required this.postModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            CardVoteDetailsComponent(),
            Spacer(),
            CardCommentDetailsComponent(),
            CardSaveDetailsComponent(),
          ],
        ),
      ],
    );
  }
}
