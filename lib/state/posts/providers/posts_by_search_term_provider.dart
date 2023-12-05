
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/constants/firebase_field_name.dart';
import 'package:flutter_instagram/state/posts/models/post.dart';
import 'package:flutter_instagram/state/posts/typedefs/search_term.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postBySearchTermProvider = StreamProvider
    .family
    .autoDispose<Iterable<Post>, SearchTerm>((ref, searchTerm)
    {
      final controller=StreamController<Iterable<Post>>();

      final sub=FirebaseFirestore
        .instance
        .collection(FirebaseCollectionName.posts)
        .orderBy(FirebaseFieldName.createdAt,descending: true)
        .snapshots()
        .listen((event) {
          final posts=event.docs
              .map((doc)=>Post(
              json: doc.data(),
              postId: doc.id,
          )).where((post) => post.message
              .toLowerCase()
              .contains(searchTerm.toLowerCase()));
          controller.sink.add(posts);


        });


      ref.onDispose(() {
        sub.cancel();
        controller.close();
      });

      return controller.stream;
    },
);