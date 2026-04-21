class SupportModel {
  int? id;
  String? title;
  String? content;
  String? createdBy;
  String? image;

  SupportModel({
    this.id,
    this.title,
    this.content,
    this.createdBy,
    this.image,
  });

  SupportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdBy = json['created_by'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['created_by'] = createdBy;
    data['image'] = image;
    return data;
  }
}