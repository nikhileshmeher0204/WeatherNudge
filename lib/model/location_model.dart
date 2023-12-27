class LocationModel {
  String? name;
  Map<String, dynamic>? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  LocationModel({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = {};
    if (json['local_names'] != null) {
      final Map<String, dynamic> localNamesMap =
      Map<String, dynamic>.from(json['local_names']);
      localNamesMap.forEach((key, value) {
        localNames![key] = value.toString();
      });
    }
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['local_names'] = localNames;
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
