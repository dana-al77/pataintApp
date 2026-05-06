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
          title: const Center(
              child: Text(
                "رفع التحاليل الطبية",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))),
      backgroundColor: AppColor.backgroundColor,
      body: GetBuilder<MedicalTestController>(
        builder: (controller) => handlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formstate,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                /// 📂 واجهة اختيار الملف (التصميم اللي طلبتيه)
                GestureDetector(
                  onTap: () => controller.chooseFile(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "اختيار الملف",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 200, // زدنا الارتفاع شوي عشان يكفي الشريطة الخضراء
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.secondyColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColor.secondyColor,
                            width: 1.5,
                          ),
                        ),
                        child: controller.file != null
                            ? _buildFilePreview(controller) // عرض الملف مع شريط التحميل
                            : _buildUploadPlaceholder(), // عرض شكل "اسحب وأسقط"
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🧪 حقل نوع التحليل
                TextFormField(
                  controller: controller.testType,
                  decoration: const InputDecoration(
                    labelText: "نوع التحليل (Test Type)",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                /// 📝 حقل الملاحظات
                TextFormField(
                  controller: controller.notes,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "ملاحظات (Notes)",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                /// 🚀 زر الرفع النهائي
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondyColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => controller.uploadTest(),
                  child: const Text("إرسال التحليل للسيرفر", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✨ دالة عرض الملف المختار مع شريط التحميل الأخضر (التصميم الواقعي)
  Widget _buildFilePreview(MedicalTestController controller) {
    String path = controller.file!.path;
    String fileName = path.split('/').last;
    bool isImage = path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png');

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // أيقونة تدل على نوع الملف
          Icon(
            isImage ? Icons.image : Icons.insert_drive_file,
            size: 50,
            color: AppColor.secondyColor,
          ),
          const SizedBox(height: 10),
          // اسم الملف
          Text(
            fileName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 15),
          // شريط التحميل الأخضر
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:  LinearProgressIndicator(
                    value: controller.uploadProgress, // بدل 1.0 نضع المتغير
                    backgroundColor: Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        controller.uploadProgress == 1.0 ? Colors.green : Colors.blue
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
// عرض النسبة المئوية متغيرة
              Text(
                "${(controller.uploadProgress * 100).toInt()}%",
                style: TextStyle(
                    color: controller.uploadProgress == 1.0 ? Colors.green : Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ),            ],
          ),
          const SizedBox(height: 8),
          const Text("جاهز للرفع", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  /// ☁️ دالة شكل الرفع الافتراضي (Placeholder)
  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_upload_outlined, size: 60, color: AppColor.secondyColor),
        const SizedBox(height: 10),
        const Text("اسحب وأسقط صورتك أو ملفك هنا", style: TextStyle(color: Colors.black54, fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          "أو اختر ملفاً",
          style: TextStyle(
            color: AppColor.secondyColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}