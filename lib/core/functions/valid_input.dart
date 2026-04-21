import 'package:get/get.dart';

validInput(String val ,int min ,int max ,String type) {
  List<String> allowedValues = ["A", "B", "C"];


  if (type == "enum") {
    if (!allowedValues.contains(val)) {
      return "القيمة المدخلة غير صالحة"; // ممكن تعوّض برسالة ترجمة
    }
  }

  if (type == "name") {


  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "34".tr;
    }
  }
  if (type == "boolean") {
    // if(!GetUtils.isEmail(val)){
    //   return "34".tr;
    // }

  }
  if (type == "date") {
    // regex لتأكد من صيغة yyyy-mm-dd
    RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(val)) {
      return "التاريخ غير صالح، يجب أن يكون بصيغة yyyy-mm-dd";
    }
    try {
      DateTime parsed = DateTime.parse(val);
    } catch (e) {
      return "التاريخ غير صالح";
    }
  }
  if (type == "number") {
    // if(!GetUtils.isEmail(val)){
    //   return "34".tr;
    // }

  }
  if (type == "password") {
    RegExp regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(val)) {
      return "كلمة المرور يجب أن تحتوي على حرف كبير وصغير ورقم ورمز خاص، وأن لا تقل عن 8 أحرف.";
    }
  }

  if (type == "image") {
    // if(!GetUtils.isPhoneNumber(val)){
    //   return "35".tr;
    // }

  }
  if (val.length < min) {
    return "36".tr + min.toString();
  }

  if (val.length > max) {
    return "37".tr + max.toString();
  }
  // if(val.isEmpty){
  //   return "38".tr ;
  // }
}
String? phoneValidator(String? val) {
  String restNumber = val!.replaceFirst("+963 9", "").replaceAll(" ", "");
  if (restNumber.length != 8 || !RegExp(r'^\d{8}$').hasMatch(restNumber)) {
    return "الرقم يجب أن يحتوي على 8 أرقام بعد +963 9";
  }
  return null;
}