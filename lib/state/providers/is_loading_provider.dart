import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:flutter_instagram/state/image_upload/provider/image_upload_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider=Provider<bool>((ref){
    final authState = ref.watch(authStateProvider);
    final isUploadingImage=ref.watch(imageUploadProvider);
    return authState.isLoading || isUploadingImage;
  }
);
