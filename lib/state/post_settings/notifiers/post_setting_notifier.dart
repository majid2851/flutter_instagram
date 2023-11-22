
import 'dart:collection';

import 'package:flutter_instagram/state/post_settings/model/post_setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostSettingNotifier
    extends StateNotifier<Map<PostSetting,bool>>
{
  PostSettingNotifier():super(
    UnmodifiableMapView({
      for(final setting in PostSetting.values) setting:true
    })
  );

  void setSetting(
    PostSetting setting,
    bool value,
  ){
    final existingValue = state[setting];
    if(existingValue == null || existingValue ==value)
    {
      return;
    }
    Map<PostSetting, dynamic> newState = Map.from(state);
    newState[setting] = value;
    state = Map.unmodifiable(newState);
  }

}