
import 'dart:io';
import 'package:flutter_instagram/state/image_upload/models/file_type.dart';
import 'package:flutter_instagram/state/image_upload/typedefs/is_loading.dart';
import 'package:flutter_instagram/state/posts/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../post_settings/model/post_setting.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading>
{
  ImageUploadNotifier():super(false);

  set isLoading(bool value){
    state=value;
  }

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting,bool> postSettings,
    required UserId userId,
  }) async{
    isLoading = true;
  }
}



