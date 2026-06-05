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
  // Future<void> chooseFile() async {
  //   FilePickerResult? result = await FilePicker.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
  //   );
  //
  //   if (result != null && result.files.single.path != null) {
  //     file = File(result.files.single.path!);
  //     fileName = result.files.single.name;
  //     // --- محاكاة التحميل ---
  //     uploadProgress = 0;
  //     update();
  //
  //     // أنيميشن بسيط لجعل الشريط يزحف لـ 100%
  //     for (int i = 0; i <= 10; i++) {
  //       await Future.delayed(const Duration(milliseconds: 200));
  //       uploadProgress = i / 10; // تزداد من 0.1 إلى 1.0
  //       update();
  //     }
  //   }
  //
  //   update();
  // }

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
  // Future<void> chooseFile() async {
  //   // استخدام FilePicker لاختيار ملف واحد أو أكثر
  //   FilePickerResult? result = await FilePicker.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
  //     allowMultiple: true, // تفعيل اختيار أكثر من ملف في المرة الواحدة
  //   );
  //
  //   if (result != null) {
  //     for (var pickedFile in result.files) {
  //       if (pickedFile.path != null) {
  //         File newFile = File(pickedFile.path!);
  //
  //         // إضافة الملف للقائمة بدلاً من استبداله
  //         selectedFiles.add(newFile);
  //
  //         // الحصول على مكان الملف الحالي في القائمة للتحكم بنسبة تحميله
  //         int currentIndex = selectedFiles.length - 1;
  //
  //         // بدء محاكاة التحميل لهذا الملف تحديداً
  //         _startIndividualUploadSimulation(currentIndex);
  //       }
  //     }
  //     update(); // تحديث الواجهة لإظهار الملفات الجديدة فوراً
  //   }
  // }

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
  /// 🚀 رفع التحليل
  uploadTest() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      if (selectedFiles.isEmpty) {
        Get.snackbar("تنبيه", "اختر ملف أولاً");
        return;
      }

      try {
        statusRequest = StatusRequest.loading;
        update();

        var response = await medicalTestData.postData(
          testType: testType.text,
          notes: notes.text,
         // files: selectedFiles,
          files: selectedFiles
              .where((e) => e.path != null)
              .map((e) => File(e.path!))
              .toList(),
        );

        print("===== Upload Test Response: $response");

        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == true) {
            Get.snackbar("نجاح", "تم رفع التحليل");
            selectedFiles.clear();
            filesProgress.clear();
            testType.clear();
            notes.clear();

          } else {
            Get.defaultDialog(
              title: "Error",
              middleText: response['message'] ?? "Upload failed",
            );
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        // هنا سيطبع لك أي خطأ يحدث حتى لو السيرفر مطفأ تماماً
        print("❌ حدث خطأ غير متوقع: $e");
        statusRequest = StatusRequest.serverfailure;
      }

      update();
    }
  }


  @override
  void onInit() {
    testType = TextEditingController();
    notes = TextEditingController();

    medicalTestData = MedicalTestData(Get.find());

    super.onInit();
  }
}