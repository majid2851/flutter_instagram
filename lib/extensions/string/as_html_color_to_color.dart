
import 'package:flutter/material.dart';
import 'package:flutter_instagram/extensions/string/remove_all.dart';

extension AsHtmlColorToColor on String
{
  Color htmlColorToColor() {
    return Color(
      int.parse(
        removeAll(['0x','#']).padLeft(8,'ff'),
        radix: 16,
      )
    );
  }

}