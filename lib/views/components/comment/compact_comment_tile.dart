
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/user_info/providers/user_info_model_provider.dart';
import 'package:flutter_instagram/views/components/animations/small_error_animation_view.dart';
import 'package:flutter_instagram/views/components/rich_two_parts_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/comments/models/comment.dart';

class CompactCommentTile extends ConsumerWidget
{
  final Comment comment;

  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (data){
        return RichTwoPartsText(
            leftPart: data.displayName,
            rightPart:comment.comment,
        );
      },
      loading: (){
        return CircularProgressIndicator();
      },
      error: (error,stackTrace){
        return SmallErrorAnimationView();
      },
    );
  }
}

