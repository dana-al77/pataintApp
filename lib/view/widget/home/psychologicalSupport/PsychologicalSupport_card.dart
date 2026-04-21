import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/color.dart';
import '../../../../data/model/support_model.dart';

class PsychologicalSupportCard extends StatelessWidget {
final  SupportModel supportModel;

const PsychologicalSupportCard({super.key, required this.supportModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color:AppColor.secondyColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.001),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // توسيط المحتوى عمودياً
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // حواف دائرية للصورة
            child: supportModel.image!.isNotEmpty
                ? Image.network(
              supportModel.image ?? "",
              width: 80, // حجم مناسب للصورة المستطيلة
              height: 80, // حجم مناسب للصورة المستطيلة
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 40,
                );
              },
            )
                : const Icon(
              Icons.spa_outlined,
              color: Colors.grey,
              size: 40,
            ),
          ),
          const SizedBox(width: 15), // مسافة أكبر بين النص والصورة

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // توسيط النصوص عمودياً
              children: [
                // العنوان - لونه أسود وواضح
                Text(
                  supportModel.title ?? "",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

             //   const SizedBox(height: 3),

                // المحتوى - لونه رمادي غامق مع مسافة بين الأسطر
                Text(
                  supportModel.content ?? "",
                  maxLines: 4, // يمكن زيادة هذا العدد إذا لزم الأمر
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    height: 1.5, // مسافة مناسبة بين الأسطر لراحة العين
                  ),
                ),





              ],
            ),
          ),


          // الصورة التوضيحية للموضوع

        ],
      ),
    );
  }
}