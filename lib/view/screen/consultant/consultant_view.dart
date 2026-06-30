import 'package:flutter/material.dart';

import '../../../controller/consltant/consultant_controller.dart';
import 'package:get/get.dart';

import '../../../core/class/statusrequest.dart';
class ConsultantsView extends StatelessWidget {
  const ConsultantsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConsultantController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("الاستشاريون"),
      ),
      body:
      GetBuilder<ConsultantController>(
        builder: (controller) {
          if (controller.statusRequest ==
              StatusRequest.loading) {
            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.consultants.length,
            itemBuilder: (context, index) {
              final consultant = controller.consultants[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 18),
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [

                        /// الصورة والاسم والحالة
                        Row(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                image:DecorationImage(
                                  image: NetworkImage(
                                    consultant.profileImage ?? "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    consultant.name ?? "",
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    consultant.specialization ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue
                                          .withOpacity(.1),
                                      borderRadius:
                                      BorderRadius.circular(
                                          20),
                                    ),
                                    child: Text(
                                      consultant.type ==
                                          "internal"
                                          ? "استشاري داخلي"
                                          : "استشاري خارجي",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                consultant.isActive == 1
                                    ? Colors.green
                                    .withOpacity(.15)
                                    : Colors.red
                                    .withOpacity(.15),
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Text(
                                consultant.isActive == 1
                                    ? "متاح"
                                    : "غير متاح",
                                style: TextStyle(
                                  color:
                                  consultant.isActive == 1
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Divider(),

                        const SizedBox(height: 10),

                        /// الخبرة والأجرة
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue
                                      .withOpacity(.08),
                                  borderRadius:
                                  BorderRadius.circular(
                                      15),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.work_history,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${consultant.yearsOfExperience} سنة",
                                      style:
                                      const TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "سنوات الخبرة",
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Container(
                                padding:
                                const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange
                                      .withOpacity(.08),
                                  borderRadius:
                                  BorderRadius.circular(
                                      15),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.payments,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${consultant.consultationFee} ل.س",
                                      style:
                                      const TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "أجرة الاستشارة",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// زر التواصل
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed:
                            consultant.isActive == 0
                                ? null
                                : () {
                              controller
                                  .createPayment(
                                consultant,
                              );
                            },
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "تواصل عبر واتساب",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.green,
                              elevation: 3,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    16),
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
        },
      ),
    );
  }
}