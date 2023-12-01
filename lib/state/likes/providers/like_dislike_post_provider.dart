
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/constants/firebase_field_name.dart';
import 'package:flutter_instagram/state/likes/models/like_dislike_request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/like.dart';

final likeDislikePostProvidre=FutureProvider
    .family
    .autoDispose<bool,LikeDislikeRequest>
      ((ref,LikeDislikeRequest request) async{
      final query = FirebaseFirestore
          .instance
          .collection(FirebaseCollectionName.likes)
          .where(FirebaseFieldName.postId,isEqualTo: request.postId)
          .where(FirebaseFieldName.userId,isEqualTo: request.likeBy)
          .get();


      final hasLiked=await query.then((snapshot) =>
        snapshot.docs.isNotEmpty
      );
      if(hasLiked){
        try{
          await query.then((snapshot) async{
            for(final doc in snapshot.docs){
              await doc.reference.delete();
            }
          });
          return true;
        }catch(_){
          return false;
        }
      }else{
        //post a like object
        final like=Like(
          postId: request.postId,
          userId:request.likeBy ,
          date:DateTime.now() ,
        );

        try{
          await FirebaseFirestore
              .instance
              .collection(FirebaseFieldName.likes)
              .add(like);
          return true;

        }catch(_){
          return false;
        }
      }

    });







