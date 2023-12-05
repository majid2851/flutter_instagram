
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/image_upload/extensions/get_collection_name_from_file_type.dart';
import 'package:flutter_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:flutter_instagram/state/posts/typedefs/post_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firebase_field_name.dart';
import '../models/post.dart';


class DeletePostStateNotifier extends StateNotifier<IsLoading>
{
  DeletePostStateNotifier():super(false);

  set isLoading(bool value) {
    state=value;
  }

  Future<bool> deletePost({
    required Post post,
  }) async {
      isLoading=true;
      try{
        //delete the post's thumbnail
        await FirebaseStorage
            .instance
            .ref()
            .child(post.userId)
            .child(FirebaseCollectionName.thumbnails)
            .child(post.thumbnailStorageId)
            .delete();

        // delete the original image or video
        await FirebaseStorage
            .instance
            .ref()
            .child(post.userId)
            .child(post.fileType.collectionName)
            .child(post.originalFileStorageId)
            .delete();

        //delete all comments assosiate with this post

        await _deleteAllDocuments(
          inCollection: FirebaseCollectionName.comments,
          postId: post.postId,
        );

        //delete all likes assosiate with this post

        await _deleteAllDocuments(
          inCollection: FirebaseCollectionName.likes,
          postId: post.postId,
        );

        //delete post itself
        final postInCollection=await FirebaseFirestore
          .instance
          .collection(FirebaseCollectionName.posts)
          .where(FieldPath.documentId,isEqualTo: post.postId)
          .limit(1)
          .get();

        for(final post in postInCollection.docs)
        {
          await post.reference.delete();


        }



        return true;
      }catch(_){
        return false;
      }finally{
        isLoading=false;
      }

    }

  }

Future<void> _deleteAllDocuments({
   required PostId postId,
   required String inCollection
}){
   return FirebaseFirestore
          .instance
          .runTransaction(
            maxAttempts: 3,
            timeout: const Duration(seconds: 20),
            (transaction) async
            {
              final query=await FirebaseFirestore
                  .instance
                  .collection(inCollection)
                  .where(
                    FirebaseFieldName.postId,
                    isEqualTo: postId
                  ).get();
              for(final doc in query.docs)
              {
                transaction.delete(doc.reference);
              }

            },
          );


}







