import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:patientapp/view/screen/NotificationView.dart';
import 'package:patientapp/view/screen/appiontement/first_appiontement_view.dart';
import 'package:patientapp/view/screen/auth/complete_profile_view.dart';
import 'package:patientapp/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:patientapp/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:patientapp/view/screen/auth/forgetpassword/verfiycode.dart';
import 'package:patientapp/view/screen/auth/login.dart';
import 'package:patientapp/view/screen/auth/sign_up.dart';
import 'package:patientapp/view/screen/auth/verfiy_code_sign_up.dart';
import 'package:patientapp/view/screen/chat/chat_view.dart';
import 'package:patientapp/view/screen/home.dart';
import 'package:patientapp/view/screen/homescreen.dart';
import 'package:patientapp/view/screen/onboarding.dart';
import 'package:patientapp/view/screen/profile/profile_page.dart';
import 'package:patientapp/view/screen/upload_medical.dart';
import 'package:patientapp/view/widget/home/centerInfo/list_center_info.dart';
import 'package:patientapp/view/widget/home/doctor/doctor_page.dart';

import 'core/constant/routes.dart';
import 'core/middleware/my_middleware.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Onboarding()
     , middlewares: [MyMiddeeWare()]
  ),
  // onBoearding

  //GetPage(name: AppRoute.onBoarding, page: () => const Onboarding()),
  //
  // /// Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signup, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetpassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verfiycode, page: () => const VerfiyCodeSignUp()),
  GetPage(name: AppRoute.completeProfile, page: () => const CompleteProfile()),

   GetPage(name: AppRoute.resetpassword, page: () => const Resetpassword()),
  // GetPage(
  //     name: AppRoute.successresertpassword,
  //     page: () => const SuccessResetPassword()),
  // GetPage(name: AppRoute.successsignup, page: () => const SuccessSignUp()),
  GetPage(
      name: AppRoute.verfiycodeforpass, page: () => const VerfiyCodeForPass()),
  ///////////////////////

  GetPage(name: AppRoute.Home, page: () => const Home()),
  GetPage(name: AppRoute.HomeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoute.firstAppiont, page: () => const FirstAppiontementView()),
  GetPage(name: AppRoute.chat, page: () =>  ChatView()),
  GetPage(name: AppRoute.AllDoctor, page: () =>  DoctorsPage()),
  GetPage(name: AppRoute.CenterInfo, page: () =>  ListCenterInfo()),
  GetPage(name: AppRoute.notification, page: () =>  Notificationview()),
  GetPage(name: AppRoute.getProfile, page: () =>  ProfilePage()),

  GetPage(name: AppRoute.upLoadMedical, page: () =>  UploadMedical()),


];
