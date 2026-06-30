import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/class/statusrequest.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../data/datasource/remote/upload_medical_data.dart';


class MedicalTestController extends GetxController {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController testType;
  late TextEditingController notes;

  File? file;
  double uploadProgress = 0;
  StatusRequest statusRequest = StatusRequest.none;

  late MedicalTestData medicalTestData;

  MyServices myServices = Get.find();


  String? fileName;
  List<PlatformFile> selectedFiles = [];
  // 1️⃣ تحويل المتغير إلى قائمة ملفات
  var selectedAnalysisType = 'Blood Test'.obs;
  void changeAnalysisType(String type) {
    selectedAnalysisType.value = type;
  }

  //List<File> selectedFiles = [];
  // 2️⃣ قائمة لتخزين نسب التحميل لكل ملف (اختياري حسب منطق الرفع لديك)
  Map<int, double> filesProgress = {};
  String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }


  final ImagePicker _picker = ImagePicker();
  Future<void> takePhoto() async {
    try {
      // تشغيل الكاميرا لالتقاط صورة واحدة فقط
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80, // اختياري: لتقليل حجم الصورة والحفاظ على الأداء
      );

      if (photo != null) {
        // تحويل XFile إلى PlatformFile ليتم التعامل معه بنفس منطق الـ FilePicker تماماً
        // (إذا كانت قائمة selectedFiles لديكِ تعتمد على نوع PlatformFile)
        final platformFile = PlatformFile(
          path: photo.path,
          name: photo.name,
          size: await photo.length(),
        );

        // إضافة الصورة الملتقطة إلى القائمة الخاصة بكِ
        selectedFiles.add(platformFile);

        // بدء محاكاة الرفع كما تفعلين مع الملفات العادية
        int currentIndex = selectedFiles.length - 1;
        _startIndividualUploadSimulation(currentIndex);

        update(); // تحديث الواجهة لظهور الملف الجديد
      }
    } catch (e) {
      print("Error picking image from camera: $e");
    }
  }

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      allowMultiple: true,
    );

    if (result != null) {
      for (var pickedFile in result.files) {
        selectedFiles.add(pickedFile);

        int currentIndex = selectedFiles.length - 1;

        _startIndividualUploadSimulation(currentIndex);
      }

      update();
    }
  }

  // دالة منفصلة لإدارة أنيميشن التحميل لكل ملف على حدة
  void _startIndividualUploadSimulation(int index) async {
    filesProgress[index] = 0.0;
    update();

    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      filesProgress[index] = i / 10;
      update(); // تحديث الواجهة لرؤية تقدم الشريط الأخضر
    }
  }

  // دالة إضافية لمسح ملف من القائمة
  void removeFile(int index) {
    selectedFiles.removeAt(index);
    filesProgress.remove(index); // مسح نسبة التحميل الخاصة به
    update();
  }
  IconData getFileIcon(String extension) {
    switch (extension.toLowerCase()) {

      case 'pdf':
        return Icons.picture_as_pdf;

      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;

      case 'doc':
      case 'docx':
        return Icons.description;

      default:
        return Icons.insert_drive_file;
    }
  }
  /// 🚀 رفع التحليل (النسخة النهائية المتوافقة)
  uploadTest() async {
    // 1️⃣ حماية: التأكد أن الفورم مرتبط بالكنترولر
    if (formstate.currentState == null) {
      print("===== ❌ خطأ: الـ formstate غير مرتبط بالواجهة");
      return;
    }

    // 2️⃣ التحقق من صحة البيانات
    if (formstate.currentState!.validate()) {
      if (selectedFiles.isEmpty) {
        Get.snackbar("تنبيه", "اختر ملف أولاً");
        return;
      }

      try {
        statusRequest = StatusRequest.loading;
        update(); // عرض اللودر

        // 3️⃣ الاتصال بالسيرفر
        var responseEither = await medicalTestData.postData(
          testType: testType.text,
          notes: notes.text,
          files: selectedFiles
              .where((e) => e.path != null)
              .map((e) => File(e.path!))
              .toList(),
        );

        // 4️⃣ معالجة النتيجة باستخدام fold
        responseEither.fold(
              (statusRequestError) {
            // الجانب الأيسر (Left): خطأ تقني (اتصال، سيرفر، إكسبشن)
            print("===== ❌ خطأ تقني: $statusRequestError");
            statusRequest = statusRequestError;
          },
              (responseMap) {
            // الجانب الأيمن (Right): تم الاتصال بالسيرفر بنجاح، لنفحص البيانات (Map)
            print("===== ✅ رد السيرفر: $responseMap");

            if (responseMap['status'] == false) {
              // حالة خاصة: السيرفر رد بـ false (مثلاً: لا يوجد سجل طبي)
              print("===== 2. اكتشاف حالة: لا يوجد سجل طبي (noData)");
              statusRequest = StatusRequest.noData;
            } else {
              // حالة النجاح الحقيقي
              print("===== 3. النجاح التام");
              statusRequest = StatusRequest.success;

                        Get.snackbar(
                          "تم بنجاح",
                          "تم رفع التحليل الطبي بنجاح",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: const Color(0xFF10B981),
                          colorText: Colors.white,
                          borderRadius: 16,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          icon: const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          duration: const Duration(seconds: 2),
                        );
                        selectedFiles.clear();
                        filesProgress.clear();
                        testType.clear();
                        notes.clear();

              // تصفير البيانات
              selectedFiles.clear();
              filesProgress.clear();
              testType.clear();
              notes.clear();
            }
          },
        );

      } catch (e) {
        // حماية إضافية لأي خطأ غير متوقع
        print("❌ 5. حدث خطأ غير متوقع: $e");
        statusRequest = StatusRequest.serverfailure;
      }

      update(); // تحديث الواجهة لعرض الحالة النهائية
    }
  }  // uploadTest() async {
  //   var formData = formstate.currentState;
  //
  //   if (formData!.validate()) {
  //     if (selectedFiles.isEmpty) {
  //       Get.snackbar("تنبيه", "اختر ملف أولاً");
  //       return;
  //     }
  //
  //     try {
  //       statusRequest = StatusRequest.loading;
  //       update();
  //
  //       var response = await medicalTestData.postData(
  //         testType: testType.text,
  //         notes: notes.text,
  //        // files: selectedFiles,
  //         files: selectedFiles
  //             .where((e) => e.path != null)
  //             .map((e) => File(e.path!))
  //             .toList(),
  //       );
  //
  //       print("===== Upload Test Response: $response");
  //
  //       statusRequest = handlingData(response);
  //
  //       if (statusRequest == StatusRequest.success) {
  //         if (response['status'] == true) {
  //           Get.snackbar(
  //             "تم بنجاح",
  //             "تم رفع التحليل الطبي بنجاح",
  //             snackPosition: SnackPosition.TOP,
  //             backgroundColor: const Color(0xFF10B981),
  //             colorText: Colors.white,
  //             borderRadius: 16,
  //             margin: const EdgeInsets.all(16),
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 20,
  //               vertical: 14,
  //             ),
  //             icon: const Icon(
  //               Icons.check_circle_rounded,
  //               color: Colors.white,
  //               size: 28,
  //             ),
  //             duration: const Duration(seconds: 2),
  //           );
  //           selectedFiles.clear();
  //           filesProgress.clear();
  //           testType.clear();
  //           notes.clear();
  //
  //         } else {
  //           Get.defaultDialog(
  //             title: "Error",
  //             middleText: response['message'] ?? "Upload failed",
  //           );
  //           statusRequest = StatusRequest.failure;
  //         }
  //       }
  //     } catch (e) {
  //       // هنا سيطبع لك أي خطأ يحدث حتى لو السيرفر مطفأ تماماً
  //       print("❌ حدث خطأ غير متوقع: $e");
  //       statusRequest = StatusRequest.serverfailure;
  //     }
  //
  //     update();
  //   }
  // }


  @override
  void onInit() {
    testType = TextEditingController();
    notes = TextEditingController();

    medicalTestData = MedicalTestData(Get.find());

    super.onInit();
  }
}