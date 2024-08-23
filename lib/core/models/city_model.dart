class CityModel {
  bool? success;
  List<CityPayload>? payload;

  CityModel({this.success, this.payload});

  CityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    payload =
        (json['payload'] as List).map((e) => CityPayload.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['payload'] = payload?.map((e) => e.toJson()).toList();
    return data;
  }
}

class CityPayload {
  String? uid;
  String? name;
  String? radioStreamingUrl;
  bool? hasRadioStreaming;

  CityPayload(
      {this.uid, this.name, this.radioStreamingUrl, this.hasRadioStreaming});

  CityPayload.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    radioStreamingUrl = json['radio_streaming_url'];
    hasRadioStreaming = json['has_radio_streaming'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['radio_streaming_url'] = radioStreamingUrl;
    data['has_radio_streaming'] = hasRadioStreaming;
    return data;
  }
}
