
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/'
    'image_upload/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../typedefs/comment_id.dart';

class DeleteCommentStateNotifier extends StateNotifier<IsLoading>
{
  DeleteCommentStateNotifier():super(false);

  set isLoading(bool value) => state=value;

  Future<bool> deleteComment({
    required CommentId commentId,
  }) async
  {
    try{
      isLoading=true;
      final query = FirebaseFirestore
        .instance
        .collection(FirebaseCollectionName.comments)
        .where(
          FieldPath.documentId,
          isEqualTo: commentId,
        )
        .limit(1)
        .get();

      await query.then((value) async {
        for(final doc in value.docs)
        {
          await doc.reference.delete();
        }
      });

      return true;
    }catch(_) {
      return false;

    }finally{
      isLoading = false;
    }


  }

}


