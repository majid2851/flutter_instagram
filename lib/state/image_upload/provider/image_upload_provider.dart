
import 'package:flutter_instagram/state/image_upload/notifier/image_upload_notifier.dart';
import 'package:flutter_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageUploadProvider = StateNotifierProvider<ImageUploadNotifier,IsLoading>(
        (ref) => ImageUploadNotifier()
);






