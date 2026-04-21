import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patientapp/core/constant/color.dart';

import '../../../controller/chat/chat_controller.dart';
import '../../widget/chat/chat_bottom_bar.dart';
import '../../widget/chat/chat_header.dart';
import '../../widget/chat/chat_message_item.dart';
import '../../widget/chat/typing.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController scrollController = ScrollController();
  late ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController(), permanent: true);
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ChatHeader(),
      ),

      body: GetBuilder<ChatController>(
        builder: (_) {
          scrollToBottom();

          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(12),
            children: [
              ...controller.messages.map((m) => ChatMessageItem(
                message: m,
                controller: controller,
              )),

              if (controller.isTyping)
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TypingIndicator(),
                ),
            ],
          );
        },
      ),

      /// 🔥 Bottom Bar ذكي
      bottomNavigationBar: const ChatBottomBar(),
    );
  }
}