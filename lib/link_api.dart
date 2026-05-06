class AppLink {
  // static const String server = "https://05ee-185-107-80-121.ngrok-free.app/";
  static const String server = "https://029e-193-43-149-3.ngrok-free.app/";
  // static const String server = "http://192.168.1.109:8000/";

  static const String test = "$server";
  /////// ================ Auth ================================= ///

  static const String signup = "${server}api/register";
  static const String verifyCode = "${server}api/verify-otp";
  static const String login = "${server}api/login";
  static const String completeProfile = "${server}api/patient/profile";
  static const String resendOtp = "${server}api/resend-otp";


  /// ForgetPassword
  static const String checkemail = "${server}api/forgotPassword";
  // static const String resetpassword = "${server}api/admin/password/reset";
  static const String resetpassword =
      "${server}api/resetPassword";

/////////////////////// Home //////////
  static const String getMedicalTps = "${server}api/getAdvicesForPatientsAndSuper";
  static const String getsupport = "${server}api/showPsychologicalSupport";
  static const String getCenterinfo = "${server}api/showCenterInformation";
  static const String getDoctors = "${server}api/doctors-schedules";


  /////////// Appointement

  static const String firstAppiont = "${server}api/medical-record";
  static const String availableAppointments = "${server}api/getAvailableAppointments";
  static const String bookAppointment = "${server}api/book-appointment";

///////////////  search
  static const String searchDoctorspec = "${server}api/getDoctorsWithSpecialization";


  //////////// profile
  static const String profile = "${server}api/patient/profile";
  static const String showprofile = "${server}api/showProfile";

  static const String paymentStatus = "https://egate-t.paymera.cc/api/get-payment-status";


  static const String upLoadMedical = "${server}api/uploadMedicalTest";

////////////// Review
  static const String addReview = "${server}api/addReview";
  static const String updateReview = "${server}api/updateReview";
  static const String deleteReview = "${server}api/deleteReview";


}
