import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:flutter_instagram/state/comments/providers/delete_comment_provider.dart';
import 'package:flutter_instagram/state/comments/providers/send_comment_provider.dart';
import 'package:flutter_instagram/state/image_upload/provider/image_upload_provider.dart';
import 'package:flutter_instagram/state/posts/providers/delete_post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider=Provider<bool>((ref){
    final authState = ref.watch(authStateProvider);
    final isUploadingImage=ref.watch(imageUploadProvider);
    final isSendingComment=ref.watch(sendCommentProvider);
    final isDeletingComment=ref.watch(deleteCommentProvider);
    final isDeletingPost=ref.watch(deletePostProvider);


    return authState.isLoading || isUploadingImage
        || isSendingComment || isDeletingComment
        || isDeletingPost;
  }
);
