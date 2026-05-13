import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/medical_record_qr_controller.dart';
import '../../../core/constant/color.dart';

class FullMedicalRecordView extends StatelessWidget {
  const FullMedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicalQrController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3FAFF),
        body: GetBuilder<MedicalQrController>(
          builder: (controller) {
            if (controller.medicalQrModel == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final medicalRecord = controller.medicalQrModel!.data!.medicalRecord!;

            return CustomScrollView( // أزلنا الـ Stack لأنه لا داعي له هنا
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. الهيدر
                SliverToBoxAdapter(
                  child: PremiumProfileHeader(
                    profileImage: medicalRecord.profileImage,
                    patientName: medicalRecord.patientName ?? "غير مسجل",
                    age: medicalRecord.age.toString() ?? "",
                  ),
                ),

                // 2. محتوى المعلومات (داخل Column واحد)
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: const Offset(0, -10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "المعلومات الأساسية",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          HealthOverviewGrid(
                            bloodType: medicalRecord.bloodType ?? "-",
                            weight: medicalRecord.weight?.toString() ?? "-",
                            height: medicalRecord.height?.toString() ?? "-",
                            isSmoker: medicalRecord.isSmoker ?? "-",
                            bloodPressure: medicalRecord.bloodPressure ?? "120/90",
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "لمحة عن الصحة",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 15),
                          SmartMedicalTimeline(
                            chronicDiseases: medicalRecord.chronicDiseases ?? "لا يوجد",
                            allergies: medicalRecord.allergies ?? "لا يوجد",
                            medications: medicalRecord.medications ?? "لا يوجد",
                            surgeries: medicalRecord.surgeries ?? "لا يوجد",
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "الحالة الاجتماعية",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                _buildSocialInfoTile("الحالة الاجتماعية", medicalRecord.maritalStatus ?? "-", Icons.favorite_border),
                                const SizedBox(width: 10),
                                _buildSocialInfoTile("عدد الأطفال", medicalRecord.numberOfChildren?.toString() ?? "0", Icons.child_care),
                              ],
                            ),
                          ),
                          const Text(
                            "معلومات التواصل",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          ContactInfoTiles(
                            phone: medicalRecord.phone ?? "-",
                            email: medicalRecord.email ?? "-",
                            address: medicalRecord.address ?? "-",
                            emergencyContact: medicalRecord.emergencyContact ?? "-",
                            maritalStatus: medicalRecord.maritalStatus ?? "-",
                            children: medicalRecord.numberOfChildren?.toString() ?? "0",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 3. قسم الملاحظات (أصبح الآن خارج الـ Column ليعمل السكرول بشكل صحيح)
                SliverToBoxAdapter(
                  child: BottomGlassSection(notesText: medicalRecord.notes),
                ),

                // مسافة أمان إضافية في الأسفل
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }}

// --- الهيدر الاحترافي ---
class PremiumProfileHeader extends StatelessWidget {
  final String? profileImage;
  final String patientName;
  final String age;

  const PremiumProfileHeader({
    super.key,
    this.profileImage,
    required this.patientName,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          // 1. الخلفية المنحنية
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff408bcf), Color(0xff408bcf)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),

          // 2. المحتوى مع المسافات المضغوطة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 10), // تقليل المسافة العمودية هنا

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // جهة الاسم والعمر
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patientName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // عرض العمر بالنمط الزجاجي
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.cake_outlined, color: Colors.white70, size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  "$age عام",
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 3. الدائرة الزجاجية المحيطة بالصورة (رجعت كما كانت وأفضل)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // هالة زجاجية خارجية
                        Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                          ),
                        ),
                        // الدائرة الزجاجية الوسطى (التأثير الأوضح)
                        Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                        ),
                        // صورة البروفايل الفعلية
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            image: profileImage != null
                                ? DecorationImage(
                              image: NetworkImage(profileImage!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: profileImage == null
                              ? const Icon(Icons.person, size: 40, color: Colors.white)
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// الكليبر المسؤول عن رسم الانحناء الموجود في الصورة
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// --- شبكة البيانات الصحية (Bento Grid) ---
class HealthOverviewGrid extends StatelessWidget {
  final String bloodType, weight, height, isSmoker, bloodPressure;

  const HealthOverviewGrid({
    super.key,
    required this.bloodType,
    required this.weight,
    required this.height,
    required this.isSmoker,
    required this.bloodPressure, // قيمة افتراضية
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // الصف الأول: ضغط الدم (عرض كامل) وزمرة الدم
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildBloodPressureCard(),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: _buildBloodTypeCard(),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // الصف الثاني: الوزن، العمر، التقييم

        // الصف الثالث: الطول والتدخين
        Row(
          children: [
            Expanded(child: _buildWeightCard()),
            const SizedBox(width: 10),
            Expanded(child: _buildHeightCard()),
            const SizedBox(width: 10),
            Expanded(child: _buildSmokingCard(isSmoker)),
          ],
        ),
      ],
    );
  }

  // 1. كرت ضغط الدم (النمط العريض مع الرسم البياني)
  Widget _buildBloodPressureCard() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF64B5F6), Color(0xFF408BCF)],),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("BLOOD PRESSURE", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
              Icon(Icons.timeline, color: Colors.white.withOpacity(0.5), size: 18),
            ],
          ),
          const Spacer(),
          // محاكاة للرسم البياني الموجود في الصورة
          CustomPaint(
            size: const Size(double.infinity, 30),
            painter: WavePainter(),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: bloodPressure, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const TextSpan(text: " mmHg", style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. كرت زمرة الدم (النمط الأزرق الفاتح مع أيقونة النقطة)
  Widget _buildBloodTypeCard() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF64B5F6), Color(0xFF408BCF)],),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("BLOOD TYPE", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const Spacer(),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(bloodType, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                Positioned(
                  top: 0, right: -5,
                  child: Icon(Icons.water_drop, color: Colors.white.withOpacity(0.4), size: 20),
                )
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // 3. كرت الوزن (مع مؤشر دائري)
  Widget _buildWeightCard() {
    return _buildBaseCard(
      title: "WEIGHT",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: weight,
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                ),
                const TextSpan(
                    text: " kg",
                    style: TextStyle(color: Colors.grey, fontSize: 12)
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // أيقونة الميزان لتعبر عن الوزن بشكل مباشر
          const Icon(
            Icons.scale,
            color: Colors.blueAccent, // يمكنك تغيير اللون ليتناسب مع تصميمك
            size: 33,
          ),
        ],
      ),
      isGradient: true, // حافظت على التدرج كما في كودك الأصلي
    );
  }

  // 4. كرت الطول (مع أيقونة المتر كما في الصورة)
  Widget _buildHeightCard() {
    return _buildBaseCard(
      title: "HEIGHT",
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: height, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                const TextSpan(text: " cm", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Icon(Icons.straighten, color: Colors.orangeAccent, size: 33), // أيقونة تشبه المتر
        ],
      ),
    );
  }

  // كرت التدخين
  Widget _buildSmokingCard(String status) {
    bool smoker = status.contains('نعم');
    return _buildBaseCard(
      title: "SMOKING",
      child: Column(
        children: [
          Icon(smoker ? Icons.smoking_rooms : Icons.smoke_free, color: smoker ? Colors.redAccent : Colors.green, size: 33),
          Text(smoker ? "مدخن" : "غير مدخن", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: smoker ? Colors.redAccent : Colors.green)),
        ],
      ),
    );
  }

  // كروت مساعدة للتقسيم

  Widget _buildBaseCard({required String title, required Widget child, bool isGradient = false}) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
          const Spacer(),
          Center(child: child),
          const Spacer(),
        ],
      ),
    );
  }
}

// كلاس لرسم الخط المتعرج (Wave) في كرت ضغط الدم
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var path = Path();
    path.moveTo(0, size.height / 2);
    for (var i = 0; i < 10; i++) {
      path.relativeQuadraticBezierTo(10, (i % 2 == 0 ? -10 : 10), 20, 0);
    }
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
// --- المخطط الزمني الذكي ---
class SmartMedicalTimeline extends StatelessWidget {
  final String chronicDiseases, allergies, medications, surgeries;
  const SmartMedicalTimeline({super.key, required this.chronicDiseases, required this.allergies, required this.medications, required this.surgeries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimelineItem("الأمراض المزمنة", chronicDiseases, Icons.history, isFirst: true),
        _buildTimelineItem("الحساسية", allergies, Icons.warning_amber_rounded),
        _buildTimelineItem("الأدوية", medications, Icons.medication),
        _buildTimelineItem("العمليات الجراحية", surgeries, Icons.biotech_outlined, isLast: true),
      ],
    );
  }

  Widget _buildTimelineItem(String title, String value, IconData icon, {bool isFirst = false, bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Column(
          //   children: [
          //     Container(width: 2, height: 10, color: isFirst ? Colors.transparent : Colors.blue.withOpacity(0.2)),
          //     Icon(Icons.circle, size: 12, color: const Color(0xFF0A84FF)),
          //     Expanded(child: Container(width: 2, color: isLast ? Colors.transparent : Colors.blue.withOpacity(0.2))),
          //   ],
          // ),
        //  const SizedBox(width: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(icon, color: AppColor.secondyColor, size: 20),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- كروت التواصل ---
class ContactInfoTiles extends StatelessWidget {
  final String phone, email, address, emergencyContact, maritalStatus, children;
  const ContactInfoTiles({super.key, required this.phone, required this.email, required this.address, required this.emergencyContact, required this.maritalStatus, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildInfoBox("الهاتف", phone, Icons.phone)),
            const SizedBox(width: 10),
            Expanded(child: _buildInfoBox("الطوارئ", emergencyContact,Icons.mobile_friendly)),
          ],
        ),
        const SizedBox(height: 10),
        _buildInfoBox("العنوان", address, Icons.location_on, isWide: true),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildInfoBox("الإيميل", email, Icons.email)),
            // const SizedBox(width: 8),
            // Expanded(child: _buildSmallBox("الحالة", maritalStatus)),
            // const SizedBox(width: 8),
            // Expanded(child: _buildSmallBox("الأطفال", children)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoBox(String title, String value, IconData icon, {bool isWide = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
              Icon(icon, color: AppColor.secondyColor, size: 16),
            ],
          ),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  // Widget _buildSmallBox(String title, String value) {
  //   return Container(
  //     padding: const EdgeInsets.all(10),
  //     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
  //     child: Column(
  //       children: [
  //         Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
  //         Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
  //       ],
  //     ),
  //   );
  // }
}

// --- الجزء السفلي (الملاحظات والأزرار) ---
class BottomGlassSection extends StatelessWidget {
  final String? notesText;
  const BottomGlassSection({super.key, this.notesText});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xff408bcf); // لون الهيدر الخاص بكِ

    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
      //  color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: primaryColor.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notes, size: 18, color: primaryColor),
                    const SizedBox(width: 8),
                    const Text("ملاحظات طبية", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  notesText ?? "لا توجد ملاحظات حالياً",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _actionBtn(String title, {required bool isPrimary, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? color : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isPrimary ? Colors.white : color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
Widget _buildSocialInfoTile(String label, String value, IconData icon) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xff408bcf), size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ],
      ),
    ),
  );
}