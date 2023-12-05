
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/posts/providers/all_post_provider.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/error_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/loading_animation_view.dart';
import 'package:flutter_instagram/views/components/post/post_grid_view.dart';
import 'package:flutter_instagram/views/components/post_sliver_grid_view.dart';
import 'package:flutter_instagram/views/constatns/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget
{
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final posts=ref.watch(allPostProvider);

    return RefreshIndicator(
      onRefresh: ()
      {
        ref.refresh(allPostProvider);

        return Future.delayed(
          const Duration(seconds: 1)
        );
      },
      child: posts.when(
        data: (posts)
        {
          if(posts.isEmpty)
          {
            return const EmptyContentWithTextAnimationView(
                text: Strings.noPostsAvailable
            );
          }else{
            return PostGridView(posts: posts);
          }
        },
        loading: (){
          return LoadingAnimationView();
        },
        error: (error,stackTrace){
          return ErrorAnimationView();
        },
      ),
    );

  }
}
