import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../image_upload/models/file_type.dart';
import '../../post_settings/model/post_setting.dart';
import 'post_key.dart';

// @immutable
// class Post
// {
//   final String postId;
//   final String userId;
//   final String message;
//   final DateTime createdAt;
//   final String thumbnailUrl;
//   final String fileUrl;
//   final FileType fileType;
//   final String fileName;
//   final double aspectRatio;
//   final String thumbnailStorageId;
//   final String originalFileStorageId;
//   final Map<PostSetting, bool> postSettings;
//
//   Post({
//     required this.postId,
//     required Map<String, dynamic> json,
//   })  : userId = json[PostKey.userId],
//         message = json[PostKey.message],
//         createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
//         thumbnailUrl = json[PostKey.thumbnailUrl],
//         fileUrl = json[PostKey.fileUrl],
//         fileType = FileType.values.firstWhere(
//               (fileType) => fileType.name == json[PostKey.fileType],
//           orElse: () => FileType.image,
//         ),
//         fileName = json[PostKey.fileName],
//         aspectRatio = json[PostKey.aspectRatio],
//         thumbnailStorageId = json[PostKey.thumbnailStorageId],
//         originalFileStorageId = json[PostKey.originalFileStorageId],
//         postSettings = {
//           for (final entry in json[PostKey.postSettings].entries)
//             PostSetting.values.firstWhere(
//                   (element) => element.storageKey == entry.key,
//             ): entry.value,
//         };
//
//   bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
//   bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
//
//
// }


@immutable
class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<PostSetting, bool> postSettings;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId] ?? "",
        message = json[PostKey.message] ?? "",
        createdAt = (json[PostKey.createdAt] as Timestamp?)?.toDate() ?? DateTime.now(),
        thumbnailUrl = json[PostKey.thumbnailUrl] ?? "",
        fileUrl = json[PostKey.fileUrl] ?? "",
        fileType = FileType.values.firstWhere(
              (fileType) => fileType.name == (json[PostKey.fileType] ?? ""),
          orElse: () => FileType.image,
        ),
        fileName = json[PostKey.fileName] ?? "",
        aspectRatio = json[PostKey.aspectRatio] ?? 1.0,
        thumbnailStorageId = json[PostKey.thumbnailStorageId] ?? "",
        originalFileStorageId = json[PostKey.originalFileStorageId] ?? "",
        postSettings = {
          for (final entry in ((json[PostKey.postSettings] ?? {}) as Map<String, dynamic>).entries)
            PostSetting.values.firstWhere(
                  (element) => element.storageKey == entry.key,
            ): entry.value as bool,
        };

  bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}