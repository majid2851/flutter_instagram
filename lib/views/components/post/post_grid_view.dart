
import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/components/post/post_thumbnail_view.dart';
import 'package:flutter_instagram/views/components/post_details/post_details_view.dart';
import 'package:flutter_instagram/views/post_comments/post_comments_view.dart';

import '../../../state/posts/models/post.dart';

class PostGridView extends StatelessWidget
{
  final Iterable<Post> posts;

  const PostGridView({
    super.key,
    required this.posts,

  });

  @override
  Widget build(BuildContext context)
  {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder:(context,index){
        final post=posts.elementAt(index);
        return PostThumbnailView(
            post: post,
            onTapped:()
            {
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
      },
    );
  }
}
