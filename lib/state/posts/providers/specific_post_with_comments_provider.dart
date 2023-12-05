
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/state/comments/extensions/comment_sorting_by_request.dart';
import 'package:flutter_instagram/state/comments/models/post_comments_request.dart';
import 'package:flutter_instagram/state/comments/models/post_with_comments.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/constants/firebase_field_name.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../comments/models/comment.dart';
import '../models/post.dart';

final specificPostWithCommentsProvider=StreamProvider
    .family
    //returns PostWithCommments and get PostCommentsRequest as paramter
    .autoDispose<PostWithComments,PostCommentsRequest>
        ((ref, PostCommentsRequest request,)
    {
      final controller=StreamController<PostWithComments>();
      Post? post;
      Iterable<Comment>? comments;

      void notify()
      {
        final localPost=post;
        if(localPost==null){
          return;
        }
        final localComments=(comments ?? []).applySortingFrom(request);
        final result=PostWithComments(
            post: localPost,
            comments: localComments
        );
        controller.sink.add(result);
      }
      final postSub=FirebaseFirestore
        .instance
        .collection(FirebaseCollectionName.posts)
        .where(FieldPath.documentId,isEqualTo: request.postId)
        .limit(1)
        .snapshots()
        .listen((event) {
          if(event.docs.isEmpty){// if didn't find a post
            post=null;
            comments=null;
            notify();
            return;
          }
          final doc=event.docs.first;
          if(doc.metadata.hasPendingWrites){
            return;
          }
          post=Post(
            postId: doc.id,
            json: doc.data(),
          );
          notify();
        });

      final commentsQuery = FirebaseFirestore
        .instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FirebaseFieldName.postId,isEqualTo: request.postId,
        )
        .orderBy(FirebaseFieldName.createdAt,descending: true);

      final limitedCommentsQuery=request.limit !=null
        ? commentsQuery.limit(request.limit!)
        : commentsQuery;

      final commentsSub=limitedCommentsQuery
        .snapshots()
        .listen((event) {
          comments=event.docs
              .where((doc) =>!doc.metadata.hasPendingWrites)
              .map((doc) => Comment(id:doc.id,doc.data())).toList();
          notify();
        });




      ref.onDispose(() {
        postSub.cancel();
        commentsSub.cancel();
        controller.close();
      });

      return controller.stream;
    }
  );



