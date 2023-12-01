
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_instagram/state/constants/firebase_field_name.dart';
import 'package:flutter_instagram/state/posts/typedefs/post_id.dart';

import '../../posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String,String>
{
  Like({
    required PostId postId,
    required UserId userId,
    required DateTime date,
  }):super({
    FirebaseFieldName.postId:postId,
    FirebaseFieldName.userId:userId,
    FirebaseFieldName.date:date.toIso8601String() ,
  });

}