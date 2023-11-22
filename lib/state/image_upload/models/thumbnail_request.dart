import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/'
    'image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest
{
  final File file;
  final FileType fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType
  });

  @override
  bool operator == (Object other)
  {
    return identical(this,other) ||
        other is ThumbnailRequest &&
            file == other.file &&
            fileType == other.fileType;
  }



  @override
  int get hashCode
  {
    return Object.hashAll(
      [
        runtimeType,
        file,
        fileType,
      ]
    );

  }


}







