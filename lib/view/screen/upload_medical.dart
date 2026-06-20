
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../controller/upLoad_medical_controller.dart';
import 'package:get/get.dart';
import '../../core/class/handling_data_view.dart';
import '../widget/customappbar.dart';
import '../widget/upload_medical/button.dart';
import '../widget/upload_medical/notes_field.dart';
import '../widget/upload_medical/type_medical.dart';
import '../widget/upload_medical/upload_box.dart';

class UploadMedical extends StatelessWidget {
  const UploadMedical({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicalTestController());

    return Scaffold(
      appBar: const PioneersMedicalAppBar(
        icon: Icons.description_outlined,
        title: "رفع التحاليل الطبية",

      ),

      backgroundColor: AppColor.backgroundColor,
      body: GetBuilder<MedicalTestController>(
        builder: (controller) => handlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstate,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                MedicalAssetUploader(
                  onTakePhotoPressed: () {
                    controller.takePhoto(); // الدالة الخاصة بالتقاط الصورة
                  },
                  onChooseFilePressed: () {
                    controller.chooseFile(); // الدالة الخاصة باختيار الملف
                  },
                ),
                const SizedBox(height: 20),

                /// 2️⃣ عرض الملفات المختارة (التصحيح هنا)


                AnalysisTypeSelector(
                  controller: controller, // تمرير الكنترولر المسؤول عن الواجهة
                ),

                const SizedBox(height: 15),
                /// 2️⃣ عرض الملفات المختارة (التعديل لدعم القائمة)
                if (controller.selectedFiles.isNotEmpty) ...[
                  const Text(
                    "الملفات المختارة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // عرض قائمة الملفات بالكامل
                  ListView.builder(
                    shrinkWrap: true, // مهم لأننا داخل ListView أخرى
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.selectedFiles.length,
                    itemBuilder: (context, index) {
                      return _buildFileItem(controller, index);
                    },
                  ),
                ],

                NotesInputField(
                  controller: controller.notes, // تمرير الكنترولر المسؤول عن حقل الملاحظات
                ),
                const SizedBox(height: 30),

                ConfirmUploadButton(
                  onPressed: () => controller.uploadTest(),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
  Widget _buildFileItem(MedicalTestController controller, int index) {
    var file = controller.selectedFiles[index];
    String fileName = file.name;
    String extension = file.extension ?? '';
    String fileSize = controller.formatFileSize(file.size);
    double progress = controller.filesProgress[index] ?? 0.0;

    // شرط للتحقق مما إذا كان الملف قد اكتمل رفعه بنجاح (100%)
    bool isUploadComplete = progress >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // تم التعديل لتتوسط العناصر عمودياً
        children: [
          /// 📄 أيقونة الملف
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.secondyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              controller.getFileIcon(extension),
              color: AppColor.secondyColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),

          /// معلومات الملف والتحميل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// اسم الملف
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A1C24),
                  ),
                ),
                const SizedBox(height: 5),

                /// حجم الملف + حالة النجاح (الصح الأخضر)
                Row(
                  children: [
                    Text(
                      fileSize,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (isUploadComplete) ...[
                      const SizedBox(width: 8),
                      // أيقونة تم الرفع بنجاح تظهر عند اكتمال الـ Progress
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 15,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Uploaded",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),

                // يعرض شريط التحميل فقط إذا لم ينتهِ الرفع بعد
                if (!isUploadComplete) ...[
                  const SizedBox(height: 10),
                  /// Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColor.secondyColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),

          /// زر الحذف والإلغاء الرمادي والأنيق
          GestureDetector(
            onTap: () {
              controller.removeFile(index);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                // لون خلفية خفيف جداً رمادي مائل للأحمر ليعطي تلميحاً وظيفياً ناعماً
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                // لون الأيقونة رمادي هادئ لكي لا يشتت العين، ومناسب جداً للـ UI العصري
                color: Colors.red[500],
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}