
import 'package:flutter/material.dart';

import '../../../enum/date_sorting.dart';
import '../../posts/typedefs/post_id.dart';

@immutable
class PostCommentsRequest
{
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

 const PostCommentsRequest({
    required this.postId,
    this.sortByCreatedAt=true,
    this.dateSorting=DateSorting.newestOnTop,
    this.limit
 });

  @override
  bool operator ==(covariant PostCommentsRequest other) =>
          postId == other.postId &&
          sortByCreatedAt == other.sortByCreatedAt &&
          dateSorting == other.dateSorting &&
          limit == other.limit;

  @override
  int get hashCode => Object.hashAll(
    [
      postId,
      sortByCreatedAt,
      dateSorting,
      limit,
    ],
  );


}