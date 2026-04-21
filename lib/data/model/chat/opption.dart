import 'dart:ui';

import '../../../controller/chat/chat_controller.dart';

class ChatOption {
  final String title;
  final Function(ChatController) onTap;

  ChatOption({
    required this.title,
    required this.onTap,
  });
}