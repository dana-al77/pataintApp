

class MedicalTip {
  int? id;
  String? title;
  String? content;
  String? createdBy;
  String? createdAt;

  MedicalTip({
    this.id,
    this.title,
    this.content,
    this.createdBy,
    this.createdAt,
  });

  MedicalTip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}