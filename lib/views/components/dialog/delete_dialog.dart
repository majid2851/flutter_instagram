
import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/components/dialog/alert_dialog_model.dart';

import '../constants/strings.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool>
{
  DeleteDialog({
    required String titleOfObjectToDelete
  }):super(
    title: '${Strings.delete} $titleOfObjectToDelete?',
    message: '${Strings.areYouSureYouWantToDeleteThis}'
        ' $titleOfObjectToDelete?',
    buttons: const {
      Strings.cancel:false,
      Strings.delete:true,
    }
  );




}