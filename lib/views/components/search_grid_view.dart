
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/posts/providers/posts_by_search_term_provider.dart';
import 'package:flutter_instagram/views/components/animations/data_not_found_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/error_animation_view.dart';
import 'package:flutter_instagram/views/components/post/post_grid_view.dart';
import 'package:flutter_instagram/views/components/post_sliver_grid_view.dart';
import 'package:flutter_instagram/views/constatns/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchGirdView extends ConsumerWidget
{
  final String searchTerm;

  const SearchGirdView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    if(searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentWithTextAnimationView(
            text:Strings.enterYourSearchTerm
        ),
      );
    }
    final posts=ref.watch(postBySearchTermProvider(searchTerm));

    return posts.when(
      data: (posts){
        if(posts.isEmpty){
          return SliverToBoxAdapter(child: DataNotFoundAnimationView());
        }else{
          return PostSliverGridView(posts: posts);
        }
      },
      loading: (){
        return SliverToBoxAdapter(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error,stackTrace){
        return SliverToBoxAdapter(child: ErrorAnimationView());
      },
    );


    return Container(

    );
  }
}


