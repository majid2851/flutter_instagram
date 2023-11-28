
import 'package:flutter_instagram/state/comments/notifiers/send_comment_notifier.dart';
import 'package:flutter_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendCommentProvider = StateNotifierProvider
  <SendCommentNotifier,IsLoading>(
        (ref) => SendCommentNotifier()
);