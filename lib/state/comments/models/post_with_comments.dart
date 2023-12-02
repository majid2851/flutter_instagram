
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/comments/models/comment.dart';

import '../../posts/models/post.dart';

@immutable
class PostWithComments
{
  final Post post;
  final Iterable<Comment> comments;

  PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator==(covariant PostWithComments other)
    => post==other.post &&
    const IterableEquality().equals(
      //reason of IterableEquality =>[comment1,comment2]
      // is equal to [comment2,comment1]
      comments,
      other.comments,
    );

  @override
  int get hashCode => Object.hashAll([
    post,
    comments,
  ]);


}