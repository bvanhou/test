import 'package:deliverzler/core/styles/font_styles.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/modules/community/models/post_model.dart';
import 'package:flutter/material.dart';

class CardContentDetailsComponent extends StatelessWidget {
  final PostModel postModel;

  const CardContentDetailsComponent({
    required this.postModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.h5(
                context,
                "asdfadfa",
                color: Theme.of(context).textTheme.headline4!.color,
                weight: FontStyles.fontWeightBold,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText.h6(
                context,
                "asdfadfa",
                color: Theme.of(context).textTheme.bodySmall!.color,
                weight: FontStyles.fontWeightNormal,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
