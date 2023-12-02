
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:flutter_instagram/state/posts/typedefs/post_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/firebase_field_name.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading>
{
  DeletePostStateNotifier():super(false);

  set isLoading(bool value) {
    state=value;
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
                    .where(FirebaseFieldName.postId,isEqualTo: postId).get();
                for(final doc in query.docs)
                {
                  transaction.delete(doc.reference);


                }

              },
            );


  }

}






