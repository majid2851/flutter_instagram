

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_instagram/state/auth/providers/user_id_provider.dart';
import 'package:flutter_instagram/state/comments/providers/delete_comment_provider.dart';
import 'package:flutter_instagram/views/components/animations/small_error_animation_view.dart';
import 'package:flutter_instagram/views/components/constants/strings.dart';
import 'package:flutter_instagram/views/components/dialog/alert_dialog_model.dart';
import 'package:flutter_instagram/views/components/dialog/delete_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../state/comments/models/comment.dart';
import '../../../state/user_info/providers/user_info_model_provider.dart';

class CommentTile extends ConsumerWidget
{
  final Comment comment;
  const CommentTile({super.key,required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final userInfo = ref.watch(userInfoModelProvider(
        comment.fromUserId,
    ));

    Logger().d('mag2851-'+userInfo.value.toString());

    return userInfo.when(
      data:(userInfo){
        final currentUserId=ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId==comment.fromUserId ?
          IconButton(
            onPressed:() async{
              final shouldDeleteComment=await displayDeleteDialog(context);
              if(shouldDeleteComment){
                await ref.read(deleteCommentProvider.notifier)
                    .deleteComment(commentId: comment.id);

              }
            },
            icon:const Icon(Icons.delete)
          ): null,
          title:Text(
            userInfo.displayName
          ),
          subtitle: Text(comment.comment),
        );
      },
      loading:(){
        return const Center(child: CircularProgressIndicator(),);
      },
      error:(error,stackTrace){
        return const SmallErrorAnimationView();
      },
    );

  }

  Future<bool> displayDeleteDialog(BuildContext context)
  {
    return DeleteDialog(
        titleOfObjectToDelete:Strings.comment
    ).present(context)
    .then((value) => value ?? false);
  }

}