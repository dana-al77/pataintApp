import 'package:flutter/cupertino.dart';

import 'opption.dart';
class ChatMessage {
  final String text;
  final bool isUser;
  final List<ChatOption>? options;
  final Widget? customWidget;

  bool showOptions;

  ChatMessage({
    required this.text,
    this.isUser = false,
    this.options,
    this.customWidget,
    this.showOptions = true,
  });
}