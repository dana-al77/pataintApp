
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:patientapp/core/class/statusrequest.dart';
import 'package:patientapp/core/constant/color.dart';
import '../../view/widget/button_retry.dart';
import '../constant/imageasset.dart';

class handlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const handlingDataView({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading ?
        Center(child: Lottie.asset(AppImageAsset.loading , width: 250,height: 250,repeat: true)) :
    statusRequest == StatusRequest.offlinefailure ?
    Center(child: Lottie.asset(AppImageAsset.offline , width: 250,height: 250,repeat: true)) :
    statusRequest == StatusRequest.serverfailure ?
        //////////////////// لا تنسي تحملي صورة السيرفر
    Center(child:Lottie.asset(AppImageAsset.noData , width: 250,height: 250 ,repeat: true)) :
    statusRequest == StatusRequest.failure ?
    Center(child: Lottie.asset(AppImageAsset.noData , width: 250,height: 250 ,repeat: true)) : widget;

  }
}


class handlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const handlingDataRequest({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading ?
    Center(child: Lottie.asset(AppImageAsset.loading , width: 250,height: 250,repeat: true)) :
    statusRequest == StatusRequest.offlinefailure ?
    Center(child: Lottie.asset(AppImageAsset.offline , width: 250,height: 250,repeat: true)) :
    statusRequest == StatusRequest.serverfailure ?
    //////////////////// لا تنسي تحملي صورة السيرفر
    Center(child:Lottie.asset(AppImageAsset.noData , width: 250,height: 250 ,repeat: true)) :
   widget;

  }
}
class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Widget? loadingWidget; // 👈 الجديد
  final VoidCallback? onRetry;

  const HandlingDataRequest({
    super.key,
    required this.statusRequest,
    required this.widget,
    this.loadingWidget,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {
      case StatusRequest.loading:
        return loadingWidget ?? _defaultLoading();

      case StatusRequest.offlinefailure:
        return _buildState(
           icon: Icons.wifi_off,
          // title: "لا يوجد اتصال",
          // subtitle: "تحقق من الإنترنت",
          onRetry: onRetry,
        );

      case StatusRequest.serverfailure:
      case StatusRequest.failure:
      case StatusRequest.serverExption:
        return _buildState(
           icon: Icons.cloud_off,
          // title: "تعذر تحميل البيانات",
          // subtitle: "حاول مرة أخرى",
          onRetry: onRetry,
        );

      default:
        return widget;
    }
  }

  /// fallback إذا ما مررت شي
  Widget _defaultLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildState({
     required IconData icon,
    // required String title,
    // required String subtitle,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.grey.shade400),
          // const SizedBox(height: 12),
          // Text(title, style: TextStyle(color: Colors.grey[800])),
          // const SizedBox(height: 6),
          // Text(subtitle, style: TextStyle(color: Colors.grey[500])),

          if (onRetry != null) ...[
            //const SizedBox(height: 12),
            AppButton(
              text: "إعادة المحاولة",
              icon: Icons.refresh,
              onPressed: onRetry,
            )
          ]
        ],
      ),
    );
  }
}
class HandlingDataModern extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final VoidCallback? onRetry;

  const HandlingDataModern({
    super.key,
    required this.statusRequest,
    required this.widget,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusRequest) {

    /// ✅ Loading من الكلاس الأول
      case StatusRequest.loading:
        return Center(
          child: Lottie.asset(
            AppImageAsset.loading,
            width: 250,
            height: 250,
            repeat: true,
          ),
        );

    /// ✅ Offline من الكلاس الثاني
      case StatusRequest.offlinefailure:
        return _buildState(
          icon: Icons.wifi_off_rounded,
          onRetry: onRetry,
        );

    /// ✅ Server Failure
      case StatusRequest.serverfailure:
      case StatusRequest.serverExption:
      case StatusRequest.failure:
        return _buildState(
          icon: Icons.cloud_off_rounded,
          onRetry: onRetry,
        );
      case StatusRequest.noData:
        return _buildState(
          icon: Icons.assignment_late_outlined,
          title: "لا يوجد سجل طبي", // نص مخصص
          subTitle: "عذراً، لم يتم العثور على سجل طبي للمريض", // نص مخصص
        );
      default:
        return widget;
    }
  }
  Widget _buildState({
    required IconData icon,
    VoidCallback? onRetry,
    String title = "اباال", // قيمة افتراضية
    String subTitle = "رتلابارلاتى", // قيمة افتراضية
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color:AppColor.secondyColor),
          ),
          const SizedBox(height: 20),
          Text(
            title, // تم التعديل هنا لاستخدام المتغير
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subTitle, // تم التعديل هنا لاستخدام المتغير
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            AppButton(
              text: "إعادة المحاولة",
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ]
        ],
      ),
    );
  }
/*  Widget _buildState({
    required IconData icon,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "تعذر تحميل البيانات",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "يرجى المحاولة مرة أخرى",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),

          if (onRetry != null) ...[
            const SizedBox(height: 24),

            AppButton(
              text: "إعادة المحاولة",
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
          ]
        ],
      ),
    );
  }*/
}