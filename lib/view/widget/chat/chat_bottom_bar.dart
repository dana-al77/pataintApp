import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/chat/chat_controller.dart';
import '../../../core/constant/color.dart';

class ChatBottomBar extends StatelessWidget {
  const ChatBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        if (controller.isInMain) return const SizedBox();

        final isBack = controller.canGoBack;

        return Container(
          color: AppColor.white, // 👈 مهم جداً يغطي تحت

          child: SafeArea(
            top: false, // 👈 لا تترك فراغ فوق
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isBack ? Icons.arrow_back : Icons.menu,
                    color: Colors.grey.shade700,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isBack) {
                          controller.goBack();
                        } else {
                          controller.showWelcome();
                        }
                      },
                      child: Text(
                        isBack ? "رجوع" : "العودة للقائمة الرئيسية",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}