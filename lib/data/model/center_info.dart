class CenterInfo {
  String? location;
 // String? openingHours;

  Map<String, String>? openingHours;
  String? addressOnMap;
  String? branches;
  String? services;

  CenterInfo({
    this.location,
    this.openingHours,
    this.addressOnMap,
    this.branches,
    this.services,
  });

  CenterInfo.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    openingHours = json['opening_hours'] != null
        ? Map<String, String>.from(json['opening_hours'])
        : {};
    //openingHours = json['opening_hours'];
    addressOnMap = json['address_on_map'];
    branches = json['branches'];
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['opening_hours'] = openingHours;
    data['address_on_map'] = addressOnMap;
    data['branches'] = branches;
    data['services'] = services;
    return data;
  }
}