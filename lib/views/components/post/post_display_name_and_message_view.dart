import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/posts/models/post.dart';
import 'package:flutter_instagram/state/user_info/providers/user_info_model_provider.dart';
import 'package:flutter_instagram/views/components/rich_two_parts_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../animations/small_error_animation_view.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget
{
  final Post post;

  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final userInfoModel = ref.watch(
      userInfoModelProvider(post.userId,)
    );

    return userInfoModel.when(
        data: (userInfoModel){
          return RichTwoPartsText(
              leftPart: userInfoModel.displayName,
              rightPart:post.message,
          );
        },
        loading: (){
          // return Center();
          return const Center(child: CircularProgressIndicator());
        },
        error: ((error,stackTrace){
          return const SmallErrorAnimationView();
        }),
    );
  }
}
