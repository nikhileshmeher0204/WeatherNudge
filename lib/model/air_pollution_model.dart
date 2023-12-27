class AirPollutionModel {
  List<num>? coord;
  List<PollutionList>? list;

  AirPollutionModel({this.coord, this.list});

  AirPollutionModel.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? List<num>.from(json['coord'].values) : null;
    if (json['list'] != null) {
      list = <PollutionList>[];
      json['list'].forEach((v) {
        list!.add(PollutionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coord'] = coord;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PollutionList {
  int? dt;
  Main? main;
  Components? components;

  PollutionList({this.dt, this.main, this.components});

  PollutionList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    components = json['components'] != null
        ? Components.fromJson(json['components'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (components != null) {
      data['components'] = components!.toJson();
    }
    return data;
  }
}

class Main {
  int? aqi;

  Main({this.aqi});

  Main.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aqi'] = aqi;
    return data;
  }
}

class Components {
  num? co;
  num? no;
  num? no2;
  num? o3;
  num? so2;
  num? pm25;
  num? pm10;
  num? nh3;

  Components(
      {this.co,
        this.no,
        this.no2,
        this.o3,
        this.so2,
        this.pm25,
        this.pm10,
        this.nh3});

  Components.fromJson(Map<String, dynamic> json) {
    co = json['co'];
    no = json['no'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm25 = json['pm2_5'];
    pm10 = json['pm10'];
    nh3 = json['nh3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['co'] = co;
    data['no'] = no;
    data['no2'] = no2;
    data['o3'] = o3;
    data['so2'] = so2;
    data['pm2_5'] = pm25;
    data['pm10'] = pm10;
    data['nh3'] = nh3;
    return data;
  }
}
