
import 'package:flutter/material.dart';

import '../../posts/typedefs/post_id.dart';
import '../../posts/typedefs/user_id.dart';

@immutable
class LikeDislikeRequest
{
  final PostId postId;
  final UserId likeBy;

  const LikeDislikeRequest({
    required this.postId,
    required this.likeBy,
  });

}







