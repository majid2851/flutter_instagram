
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/posts/providers/user_posts_provider.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/error_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/loading_animation_view.dart';
import 'package:flutter_instagram/views/components/post/post_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../constatns/strings.dart';

class UserPostsView extends ConsumerWidget
{
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final posts=ref.watch(userPostsProvider);
    return RefreshIndicator(
        onRefresh: (){
          ref.refresh(userPostsProvider);
          return Future.delayed(const Duration(seconds: 1));
        },
        child: posts.when(
            data: (posts)
            {


              if(posts.isEmpty)
              {

                return const EmptyContentWithTextAnimationView(
                    text:Strings.youHaveNoPosts
                );
              }else{
                return PostGridView(posts:posts);
              }
            },
            error: (error,stackTrace){
              return ErrorAnimationView();
            },
            loading:(){
              return LoadingAnimationView();
            }
        ),
    );
  }
}


