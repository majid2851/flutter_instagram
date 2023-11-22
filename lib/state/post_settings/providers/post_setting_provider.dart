
import 'package:flutter_instagram/state/post_settings/model/post_setting.dart';
import 'package:flutter_instagram/state/post_settings/notifiers/post_setting_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final postSettingProvider=
    StateNotifierProvider<PostSettingNotifier,Map<PostSetting,bool>>(
        (ref) =>PostSettingNotifier(),
    );





