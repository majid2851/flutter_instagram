
import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/components/rich_text/base_text.dart';

@immutable
class LinkText extends BaseText
{
  final VoidCallback onTapped;
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style
  });

}