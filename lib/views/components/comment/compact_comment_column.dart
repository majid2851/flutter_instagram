
import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/components/comment/compact_comment_tile.dart';

import '../../../state/comments/models/comment.dart';

class CompactCommentColumn extends StatelessWidget
{
  final Iterable<Comment> comments;

  const CompactCommentColumn({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context)
  {
    if(comments.isEmpty){
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:comments.map((comment){
          return CompactCommentTile(comment: comment,);
        }).toList(),
      ),
    );


  }
}

