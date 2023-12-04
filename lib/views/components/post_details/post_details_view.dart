
import 'package:flutter/material.dart';
import 'package:flutter_instagram/enum/date_sorting.dart';
import 'package:flutter_instagram/state/comments/models/post_comments_request.dart';
import 'package:flutter_instagram/state/image_upload/models/file_type.dart';
import 'package:flutter_instagram/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:flutter_instagram/state/posts/providers/delete_post_provider.dart';
import 'package:flutter_instagram/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:flutter_instagram/views/components/animations/error_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/loading_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/small_error_animation_view.dart';
import 'package:flutter_instagram/views/components/comment/compact_comment_column.dart';
import 'package:flutter_instagram/views/components/dialog/alert_dialog_model.dart';
import 'package:flutter_instagram/views/components/dialog/delete_dialog.dart';
import 'package:flutter_instagram/views/components/like_button.dart';
import 'package:flutter_instagram/views/components/likes_count_view.dart';
import 'package:flutter_instagram/views/components/post/post_date_view.dart';
import 'package:flutter_instagram/views/components/post/post_display_name_and_message_view.dart';
import 'package:flutter_instagram/views/components/post/post_image_or_video_view.dart';
import 'package:flutter_instagram/views/post_comments/post_comments_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../state/posts/models/post.dart';
import '../../constatns/strings.dart';

class PostDetailView extends ConsumerStatefulWidget
{
  final Post post;

  const PostDetailView({
    super.key,
    required this.post,
  });

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  @override
  Widget build(BuildContext context, )
  {
    final request=PostCommentsRequest(
        postId:widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting:DateSorting.oldestOnTop,
    );

    //get the actual post together with it's comments
    final postWithComments=ref.watch(
        specificPostWithCommentsProvider(request),
    );


    final canDeletePost=ref.watch(
        canCurrentUserDeletePostProvider(widget.post),
    );




    return Scaffold(
      appBar: AppBar(title: const Text(
          Strings.postDetails,
        ),
        actions: [
          postWithComments.when(
            data: (postWithComments){
              return IconButton(
                  onPressed: (){
                    final url= postWithComments.post.fileUrl;
                    Share.share(url,subject:Strings.checkOutThisPost);

                  },
                  icon: const Icon(Icons.share),
              );
            },
            loading: (){
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error,stackTrace){
              return const SmallErrorAnimationView();
            },
          ),

          if(canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost= await DeleteDialog(
                    titleOfObjectToDelete: Strings.post
                )
                .present(context)
                .then((shouldDelete) => shouldDelete ?? false);

                if(shouldDeletePost){
                  await ref.read(deletePostProvider.notifier)
                      .deletePost(post: widget.post,);
                  if(mounted){
                    Navigator.of(context).pop();
                  }
                }

              },
            )
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments){
          final postId=postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: postWithComments.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(postWithComments.post.allowsLikes)
                      LikeButton(postId: postId,),
                    //comments button, if post allows commenting
                    if(postWithComments.post.allowsComments)
                      IconButton(
                        onPressed:(){
                          Navigator.of(context)
                            .push(MaterialPageRoute(
                              builder:(context)=>PostCommentsView(postId: postId)
                          ));
                        },
                        icon: const Icon(Icons.mode_comment_outlined),
                      )
                  ],
                ),
                PostDisplayNameAndMessageView(post: postWithComments.post),

                PostDateView(dateTime:postWithComments.post.createdAt),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(color: Colors.white70,),
                ),

                CompactCommentColumn(comments: postWithComments.comments),
                //display like count
                if(postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(postId: postId),
                      ],
                    ),
                  ),
                //add spacing to bottom of screen
                const SizedBox(
                  height: 100,
                )


              ],
            ),
          );
        },
        loading: (){
          return LoadingAnimationView();
        },
        error: (error,stackTrace){
          return ErrorAnimationView();
        },
      ),


    );
  }
}










