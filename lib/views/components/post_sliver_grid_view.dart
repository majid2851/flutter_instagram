

import 'package:flutter/material.dart';

import '../../state/posts/models/post.dart';
import 'post/post_thumbnail_view.dart';
import 'post_details/post_details_view.dart';

class PostSliverGridView extends StatelessWidget
{
  final Iterable<Post> posts;
  const PostSliverGridView({
    required this.posts,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
        ),
        delegate:SliverChildBuilderDelegate(
          childCount: posts.length,
          (context,index)
          {

            final post=posts.elementAt(index);
            return PostThumbnailView(
              post: post,
              onTapped:(){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>PostDetailView(
                            post: post
                        )
                    )
                );
              }
            );

          }
        )
    );
  }
}
