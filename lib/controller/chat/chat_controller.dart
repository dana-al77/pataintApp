import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/chat/message.dart';
import '../../data/model/chat/opption.dart';
import '../../view/screen/appiontement/first_appiontement_view.dart';
import '../../view/widget/home/doctor/doctor_card.dart';
import '../home/center_info.dart';
import '../home/doctor_controller.dart';

enum ChatFlowState {
  main,
  booking,
  doctors,
  center,
}

class ChatController extends GetxController {
  List<ChatMessage> messages = [];

  bool isTyping = false;

  /// 🔥 حالة الشات
  ChatFlowState currentState = ChatFlowState.main;

  /// 🔥 history بسيط للرجوع
  List<ChatFlowState> history = [];

  @override
  void onInit() {
    super.onInit();
    showWelcome(reset: true);
  }

  void addMessage(ChatMessage message) {
    messages.add(message);
    update();
  }

  Future<void> botReply(Function action) async {
    isTyping = true;
    update();

    await Future.delayed(const Duration(milliseconds: 1000));

    isTyping = false;
    update();

    action();
  }

  void handleOptionTap(ChatOption option) {
    if (messages.isNotEmpty) {
      messages.last.showOptions = false;
    }

    addMessage(
      ChatMessage(
        text: option.title,
        isUser: true,
      ),
    );

    botReply(() {
      option.onTap(this);
    });
  }

  /// ================== NAVIGATION ==================

  void goToState(ChatFlowState newState, Function action) {
    history.add(currentState);
    currentState = newState;
    action();
    update();
  }

  void goBack() {
    if (history.isNotEmpty) {
      currentState = history.removeLast();

      switch (currentState) {
        case ChatFlowState.main:
          showWelcome();
          break;
        case ChatFlowState.booking:
          goToBookingOptions();
          break;
        case ChatFlowState.doctors:
          showDoctorsPreview();
          break;
        case ChatFlowState.center:
          showCenterInfo();
          break;
      }
    }
  }
  bool get canGoBack => history.isNotEmpty;
  bool get canGoHome => history.isNotEmpty;

  bool get isInMain => currentState == ChatFlowState.main;

  /// ================== MAIN ==================


  void showWelcome({bool reset = false}) {
    currentState = ChatFlowState.main;

    if (reset) {
      history.clear();
    }

    addMessage(
      ChatMessage(
        text: "مرحباً 👋 كيف فيني ساعدك؟",
        options: mainOptions(),
      ),
    );
  }

  List<ChatOption> mainOptions() {
    return [
      ChatOption(
        title: "🩺 حجز موعد",
        onTap: (c) => c.goToState(ChatFlowState.booking, c.goToBookingOptions),
      ),
      ChatOption(
        title: "👨‍⚕️ عرض الأطباء",
        onTap: (c) => c.goToState(ChatFlowState.doctors, c.showDoctorsPreview),
      ),
      ChatOption(
        title: "ℹ️ معلومات المركز",
        onTap: (c) => c.goToState(ChatFlowState.center, c.showCenterInfo),
      ),
    ];
  }

  /// ================== BOOKING ==================

  void goToBookingOptions() {
    addMessage(
      ChatMessage(
        text: "بدك حجز أولي ولا مع طبيب معين؟",
        options: [
          ChatOption(
            title: "🩺 حجز أولي",
            onTap: (c) {
              Get.to(() => const FirstAppiontementView())?.then((_) {
                c.botReply(() {
                  c.showWelcome();
                });
              });
            },
          ),
          ChatOption(
            title: "👨‍⚕️ طبيب معين",
            onTap: (c) => c.showDoctorsPreview(),
          ),
        ],
      ),
    );
  }

  /// ================== DOCTORS ==================

  void showDoctorsPreview() {
    final controller = Get.find<DoctorControllerImp>();

    addMessage(
      ChatMessage(
        text: "هدول بعض الأطباء 👇",
        customWidget: Column(
          children: controller.data.take(3).map((doctor) {
            return DoctorCard(doctor: doctor);
          }).toList(),
        ),
      ),
    );
  }

  /// ================== CENTER ==================

  void showCenterInfo() {
    addMessage(
      ChatMessage(
        text: "شو بدك تعرف عن المركز؟ 👇",
        options: [
          ChatOption(
            title: "📍 العنوان",
            onTap: (c) => c.showAddress(),
          ),
          ChatOption(
            title: "🕒 أوقات العمل",
            onTap: (c) => c.showOpeningHours(),
          ),
          ChatOption(
            title: "🏥 الخدمات",
            onTap: (c) => c.showServices(),
          ),
        ],
      ),
    );
  }

  void showAddress() {
    final controller = Get.find<ViewCenetrInfoControllerImp>();
    final center = controller.data.first;

    addMessage(ChatMessage(
      text: "📍 العنوان:\n${center.addressOnMap ?? 'غير متوفر'}",
    ));
  }

  void showOpeningHours() {
    final controller = Get.find<ViewCenetrInfoControllerImp>();
    final center = controller.data.first;

    // addMessage(ChatMessage(
    //  // text: "🕒 أوقات العمل:\n${center.openingHours ?? 'غير متوفر'}",
    // ));
  }

  void showServices() {
    final controller = Get.find<ViewCenetrInfoControllerImp>();
    final center = controller.data.first;

    addMessage(ChatMessage(
      text: "🏥 الخدمات:\n${center.services ?? 'غير متوفر'}",
    ));
  }
}