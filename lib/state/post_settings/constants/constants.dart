import 'package:flutter/material.dart';

@immutable
class Constants
{

  const Constants._();

  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes,users will be able to press'
      'the like button on your post';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments,users will be able'
      'to comment on your post';
  static const allowCommentsStorageKey = 'allow_comments';


}