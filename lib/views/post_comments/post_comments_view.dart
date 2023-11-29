import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_instagram/state/auth/providers/user_id_provider.dart';
import 'package:flutter_instagram/state/comments/models/post_comments_request.dart';
import 'package:flutter_instagram/state/comments/providers/post_comments_provider.dart';
import 'package:flutter_instagram/state/comments/providers/send_comment_provider.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/error_animation_view.dart';
import 'package:flutter_instagram/views/components/animations/loading_animation_view.dart';
import 'package:flutter_instagram/views/components/comment/comment_tile.dart';
import 'package:flutter_instagram/views/extensions/dismiss_keyboard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../state/posts/typedefs/post_id.dart';
import '../constatns/strings.dart';

class PostCommentsView extends HookConsumerWidget
{
  final PostId postId;

  const PostCommentsView({
    Key? key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    final commentController = useTextEditingController();
    final hasText = useState(false);

    final request=useState(
      PostCommentsRequest(
        postId: postId,
      )
    );

    final comments = ref.watch(postCommentProvider(request.value));

    useEffect((){
      commentController.addListener(() {
        hasText.value=commentController.text.isNotEmpty;
      });
      return (){};
    },[commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: hasText.value ? (){
              _submitCommentWithController(
                  commentController,
                  ref,
              );
            }: null,


          )
        ],
      ),
      body:SafeArea(
        child:Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments)
                {
                  if(comments.isEmpty)
                  {
                    return SingleChildScrollView(
                      child: EmptyContentWithTextAnimationView(
                        text:Strings.noCommentsYet,
                      ),
                    );
                  }
                  return RefreshIndicator(
                      onRefresh:() {
                        ref.refresh(postCommentProvider(request.value));
                        return Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.builder(
                          itemCount: comments.length,
                          padding: const EdgeInsets.all(8.0),
                          itemBuilder:(context,index)
                          {
                            final comment=comments.elementAt(index);
                            return CommentTile(
                              comment: comment,
                            );

                          },
                      ),
                  );

                },
                loading: (){
                  return LoadingAnimationView(
                  );
                },
                error:(error,stackTrace){
                  return ErrorAnimationView();
                },
              ),

            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted:(comment){
                      if(comment.isNotEmpty){
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                      
                    ),

                  ),
                ),
              ),

            )
          ],
        ),

      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async
  {
    final userId = ref.read(userIdProvider);
    if(userId==null){
      return;
    }
    final isSent = await ref
        .read(sendCommentProvider.notifier)
        .sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text
        );
    if(isSent){
      controller.clear();
      dismissKeyboard();
    }


  }




}
