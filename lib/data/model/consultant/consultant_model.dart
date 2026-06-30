class ConsultantModel {
  int? id;
  String? type;
  String? name;
  String? specialization;
  String? bio;
  int? yearsOfExperience;
  String? consultationFee;
  int? isActive;
  String? profileImage;

  ConsultantModel({
    this.id,
    this.type,
    this.name,
    this.specialization,
    this.bio,
    this.yearsOfExperience,
    this.consultationFee,
    this.isActive,
    this.profileImage,
  });

  ConsultantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    specialization = json['specialization'];
    bio = json['bio'];
    yearsOfExperience = json['years_of_experience'];
    consultationFee = json['consultation_fee'];
    isActive = json['is_active'];
    profileImage = json['profile_image'];
  }
}