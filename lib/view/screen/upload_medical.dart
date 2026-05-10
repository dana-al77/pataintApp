// import 'package:flutter/material.dart';
// import 'package:patientapp/core/constant/color.dart';
// import '../../controller/upLoad_medical_controller.dart';
// import 'package:get/get.dart';
//
// import '../../core/class/handling_data_view.dart';
//
// class UploadMedical extends StatelessWidget {
//   const UploadMedical({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(MedicalTestController());
//
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColor.backgroundColor,
//           title: Center(child: const Text("رفع التحاليل الطبية",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
//     backgroundColor: AppColor.backgroundColor,
//       body: GetBuilder<MedicalTestController>(
//         builder: (controller) => handlingDataRequest(
//           statusRequest: controller.statusRequest,
//           widget: Form(
//             key: controller.formstate,
//             child: ListView(
//               padding: const EdgeInsets.all(20),
//               children: [
//
//                 /// 📂 واجهة اختيار الملف بتصميم احترافي (يطابق الصورة)
//                 GestureDetector(
//                   onTap: () => controller.chooseFile(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end, // لمحاذاة النص "اختيار الملف" لليمين
//                     children: [
//                       // const Text(
//                       //   "اختيار الملف",
//                       //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       // ),
//                       // const SizedBox(height: 10),
//                       Container(
//                         height: 180,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColor.secondyColor.withOpacity(0.05), // خلفية زرقاء فاتحة جداً
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppColor.secondyColor,
//                             width: 1.5,
//                             style: BorderStyle.solid, // ملاحظة: لرسم حدود منقطة تماماً نحتاج حزمة dotted_border
//                           ),
//                         ),
//                         child: controller.file != null
//                             ? ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.file(controller.file!, fit: BoxFit.cover),
//                         )
//                             : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.cloud_upload_outlined, // أيقونة السحابة
//                               size: 60,
//                               color: AppColor.secondyColor,
//                             ),
//                             const SizedBox(height: 10),
//                             const Text(
//                               "اسحب وأسقط صورتك أو ملفك هنا",
//                               style: TextStyle(color: Colors.black54, fontSize: 16),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               "أو اختر ملفاً",
//                               style: TextStyle(
//                                 color: AppColor.secondyColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 decoration: TextDecoration.underline, // وضع خط تحت النص
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 /// 🆔 medical_record_id
//                 // TextFormField(
//                 //   controller: controller.medicalRecordId,
//                 //   decoration: const InputDecoration(
//                 //     labelText: "Medical Record ID",
//                 //   ),
//                 // ),
//
//                 /// 🧪 نوع التحليل
//                 TextFormField(
//                   controller: controller.testType,
//                   decoration: const InputDecoration(
//                     labelText: "Test Type",
//                   ),
//                 ),
//
//                 /// 📝 ملاحظات
//                 TextFormField(
//                   controller: controller.notes,
//                   decoration: const InputDecoration(
//                     labelText: "Notes",
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 ElevatedButton(
//                   onPressed: () => controller.uploadTest(),
//                   child: const Text("رفع التحليل"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:patientapp/core/constant/color.dart';
// import '../../controller/upLoad_medical_controller.dart';
// import 'package:get/get.dart';
// import '../../core/class/handling_data_view.dart';
//
// class UploadMedical extends StatelessWidget {
//   const UploadMedical({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(MedicalTestController());
//
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: AppColor.backgroundColor,
//           title: const Center(
//               child: Text(
//                 "رفع التحاليل الطبية",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ))),
//       backgroundColor: AppColor.backgroundColor,
//       body: GetBuilder<MedicalTestController>(
//         builder: (controller) => handlingDataRequest(
//           statusRequest: controller.statusRequest,
//           widget: Form(
//             key: controller.formstate,
//             child: ListView(
//               padding: const EdgeInsets.all(20),
//               children: [
//                 /// 📂 واجهة اختيار الملف
//                 GestureDetector(
//                   onTap: () => controller.chooseFile(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       const Text(
//                         "اختيار الملف",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         height: 180,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColor.secondyColor.withOpacity(0.05),
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppColor.secondyColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: controller.file != null
//                             ? _buildFilePreview(controller) // دالة عرض المعاينة
//                             : _buildUploadPlaceholder(), // دالة شكل الرفع الفارغ
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 TextFormField(
//                   controller: controller.testType,
//                   decoration: const InputDecoration(labelText: "Test Type"),
//                 ),
//
//                 TextFormField(
//                   controller: controller.notes,
//                   decoration: const InputDecoration(labelText: "Notes"),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 ElevatedButton(
//                   onPressed: () => controller.uploadTest(),
//                   child: const Text("رفع التحليل"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// 🖼️ دالة لعرض الصورة أو أيقونة الملف بناءً على النوع
//   Widget _buildFilePreview(MedicalTestController controller) {
//     String path = controller.file!.path.toLowerCase();
//     bool isImage = path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.png');
//
//     if (isImage) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.file(controller.file!, fit: BoxFit.cover),
//       );
//     } else {
//       // إذا كان PDF أو Word
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.insert_drive_file, size: 60, color: AppColor.secondyColor),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               path.split('/').last, // استخراج اسم الملف من المسار
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       );
//     }
//   }
//
//   /// ✨ دالة شكل الرفع عندما يكون فارغاً
//   Widget _buildUploadPlaceholder() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(Icons.cloud_upload_outlined, size: 60, color: AppColor.secondyColor),
//         const SizedBox(height: 10),
//         const Text("اسحب وأسقط صورتك أو ملفك هنا", style: TextStyle(color: Colors.black54, fontSize: 16)),
//         const SizedBox(height: 5),
//         Text(
//           "أو اختر ملفاً",
//           style: TextStyle(
//             color: AppColor.secondyColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             decoration: TextDecoration.underline,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../controller/upLoad_medical_controller.dart';
import 'package:get/get.dart';
import '../../core/class/handling_data_view.dart';

class UploadMedical extends StatelessWidget {
  const UploadMedical({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicalTestController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: const Text(
          "رفع التحاليل الطبية",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
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
                /// 1️⃣ منطقة الرفع الثابتة
                GestureDetector(
                  onTap: () => controller.chooseFile(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: AppColor.secondyColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColor.secondyColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: _buildUploadPlaceholder(),
                  ),
                ),

                const SizedBox(height: 20),

                /// 2️⃣ عرض الملفات المختارة (التصحيح هنا)
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

                const SizedBox(height: 20),

                TextFormField(
                  controller: controller.testType,
                  decoration: InputDecoration(
                    // 1️⃣ تفعيل اللون الخلفي وجعله فاتحاً جداً مثل منطقة الرفع
                    filled: true,
                    fillColor: AppColor.secondyColor.withOpacity(0.05),

                    labelText: "نوع التحليل (Test Type)",
                    labelStyle: TextStyle(color: AppColor.black.withOpacity(0.5)),

                    // 2️⃣ الحدود في الحالة العادية
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColor.secondyColor.withOpacity(0.2), // حدود خفيفة
                        width: 1.5,
                      ),
                    ),

                    // 3️⃣ الحدود عند الضغط على الحقل (Focus)
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.secondyColor, // حدود واضحة عند الكتابة
                        width: 1.5,
                      ),
                    ),

                    // 4️⃣ حدود الخطأ (Validation)
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),

                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
                const SizedBox(height: 15),


                TextFormField(
                  controller: controller.notes,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 16), // تحسين حجم الخط المدخل
                  decoration: InputDecoration(
                    // 1️⃣ تفعيل الخلفية الملونة لتطابق منطقة الرفع
                    filled: true,
                    fillColor: AppColor.secondyColor.withOpacity(0.05),

                    labelText: "ملاحظات (Notes)",
                    labelStyle: TextStyle(
                      color: AppColor.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                    alignLabelWithHint: true, // لجعل النص يبدأ من الأعلى بما أن maxLines = 3

                    // 2️⃣ الحدود في الحالة الطبيعية (Enabled)
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColor.secondyColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),

                    // 3️⃣ الحدود عند النقر (Focused)
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: AppColor.secondyColor,
                        width: 1.5,
                      ),
                    ),

                    // 4️⃣ حدود الخطأ (Error)
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                    ),

                    // 5️⃣ مسافات داخلية مريحة للعيد
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondyColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => controller.uploadTest(),
                  child: const Text("تأكيد الرفع", style: TextStyle(color: Colors.white, fontSize: 16)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

          /// معلومات الملف
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// اسم الملف
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                /// حجم + نوع الملف
                Text(
                  "$fileSize • .$extension",

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 12),

                /// Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: LinearProgressIndicator(
                    value: progress,

                    minHeight: 7,

                    backgroundColor: Colors.grey[200],

                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColor.secondyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// زر الحذف
          GestureDetector(
            onTap: () {
              controller.removeFile(index);
            },

            child: Container(
              padding: const EdgeInsets.all(6),

              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.close,
                color: Colors.redAccent,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
  /// ✨ تصميم كارد الملف المختار (نفس فكرة الصورة الثانية)
  // Widget _buildFileItem(MedicalTestController controller, int index) {
  //   // الوصول للملف المحدد من القائمة باستخدام الـ index
  //   var file = controller.selectedFiles[index];
  //   String fileName = file.path.split('/').last;
  //
  //   // الوصول لنسبة التحميل الخاصة بهذا الملف من الـ Map
  //   double progress = controller.filesProgress[index] ?? 0.0;
  //
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 10),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             color: AppColor.secondyColor.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: const Icon(Icons.description, color: AppColor.secondyColor),
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 fileName,
  //                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               const SizedBox(height: 5),
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: LinearProgressIndicator(
  //                   value: progress, // القيمة المتغيرة للملف المحدد
  //                   backgroundColor: Colors.grey[200],
  //                   valueColor: AlwaysStoppedAnimation<Color>(
  //                       progress == 1.0 ? Colors.green : AppColor.secondyColor
  //                   ),
  //                   minHeight: 6,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 10),
  //         IconButton(
  //           onPressed: () {
  //             // استدعاء دالة الحذف التي أضفناها للـ controller
  //             controller.removeFile(index);
  //           },
  //           icon: const Icon(Icons.cancel, color: Colors.redAccent),
  //         )
  //       ],
  //     ),
  //   );
  // }
  // /// ☁️ شكل الرفع الافتراضي (ثابت)
  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_upload_outlined, size: 50, color: AppColor.secondyColor),
        const SizedBox(height: 10),
        const Text(
          "اسحب وأسقط صورتك أو ملفك هنا",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        const SizedBox(height: 5),
        Text(
          "أو اختر ملفاً",
          style: TextStyle(
            color: AppColor.secondyColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}