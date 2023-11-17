
import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/'
    'components/constants/strings.dart';
import 'package:flutter_instagram/views/'
    'components/dialog/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool>
{
  LogoutDialog(): super(
    title: Strings.logOut,
    message: Strings.areYouSureYouWantToLogOutOfTheApp,
    buttons: const {
      Strings.cancel:false,
      Strings.logOut:true,
    },
  );



}