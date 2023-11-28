import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../state/posts/typedefs/post_id.dart';

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

    return Container();
  }
}
