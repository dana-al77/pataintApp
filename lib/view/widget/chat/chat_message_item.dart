import 'package:flutter/material.dart';
import '../../../controller/chat/chat_controller.dart';
import '../../../data/model/chat/message.dart';
import 'bot_avatar.dart';
import 'chat_bubble.dart';
import 'quick_options.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessage message;
  final ChatController controller;

  const ChatMessageItem({
    super.key,
    required this.message,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: message.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!message.isUser) const BotAvatar(),
            const SizedBox(width: 6),

            Flexible(
              child: ChatBubble(
                text: message.text,
                isUser: message.isUser,
              ),
            ),
          ],
        ),

        if (message.customWidget != null)
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: message.customWidget!,
          ),

        if (message.options != null && message.showOptions)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 5),
            child: QuickOptionsWidget(
              options: message.options!,
              controller: controller,
            ),
          ),
      ],
    );
  }
}