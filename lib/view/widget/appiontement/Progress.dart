import 'package:flutter/material.dart';

import '../../../controller/appiontement/first_appion_controller.dart';
import '../../../core/constant/color.dart';

Widget progress(FistAppiontController c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
    child: Row(
      children: List.generate(4, (index) {
        bool isCurrent = c.isStepCurrent(index);
        bool isDone = c.isStepDone(index);

        return Expanded(
          child: Center(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   gradient: (isCurrent || isDone)
                      //       ?
                      //   const LinearGradient(
                      //     colors: AppColor.serviceGradient,
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   )
                      //       : null,
                      //   color: !(isCurrent || isDone) ? Colors.white : null,
                      //   border: Border.all(
                      //     color: isCurrent ? AppColor.secondyColor : Colors.grey.shade200,
                      //     width: 2,
                      //   ),
                      //   // التوهج يظهر فقط للخطوة الحالية
                      //   boxShadow: isCurrent
                      //       ? [
                      //     BoxShadow(
                      //       color: Colors.blue.withOpacity(0.4),
                      //       blurRadius: 12,
                      //       spreadRadius: 2,
                      //     )
                      //   ]
                      //       : [],
                      // ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: (isCurrent || isDone)
                            ? AppColor.secondyColor // 👈 لون واحد
                            : Colors.white,

                        border: Border.all(
                          color: isCurrent
                              ? AppColor.secondyColor
                              : Colors.grey.shade200,
                          width: 2,
                        ),

                        // التوهج للخطوة الحالية فقط
                        boxShadow: isCurrent
                            ? [
                          BoxShadow(
                            color: AppColor.secondyColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          )
                        ]
                            : [],
                      ),
                      child: Center(
                        child: isDone
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: isCurrent ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "الخطوة ${index + 1}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: isCurrent ? AppColor.secondyColor : AppColor.grey,
                      ),
                    ),
                  ],
                ),

                if (index < 3)
                  Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: isDone ? AppColor.secondyColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}