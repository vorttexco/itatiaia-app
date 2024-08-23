class CityScheduleModel {
  bool? success;
  SchedulePayload? payload;

  CityScheduleModel({this.success, this.payload});

  CityScheduleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    payload = json['payload'] == null
        ? null
        : SchedulePayload.fromJson(json['payload']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['payload'] = payload?.toJson();
    return data;
  }
}

class SchedulePayload {
  List<ScheduleProgram>? sunday;
  List<ScheduleProgram>? monday;
  List<ScheduleProgram>? tuesday;
  List<ScheduleProgram>? wednesday;
  List<ScheduleProgram>? thursday;
  List<ScheduleProgram>? friday;
  List<ScheduleProgram>? saturday;

  SchedulePayload(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  SchedulePayload.fromJson(Map<String, dynamic> json) {
    sunday = json['sunday'] == null
        ? []
        : (json['sunday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();
    monday = json['monday'] == null
        ? []
        : (json['monday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();

    tuesday = json['tuesday'] == null
        ? []
        : (json['tuesday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();
    wednesday = json['wednesday'] == null
        ? []
        : (json['wednesday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();
    thursday = json['thursday'] == null
        ? []
        : (json['thursday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();
    friday = json['friday'] == null
        ? []
        : (json['friday'] as List)
            .map((e) => ScheduleProgram.fromJson(e))
            .toList();
    saturday = (json['saturday'] as List)
        .map((e) => ScheduleProgram.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sunday'] = sunday?.map((e) => e.toJson()).toList();
    data['monday'] = monday?.map((e) => e.toJson()).toList();
    data['tuesday'] = tuesday;
    data['wednesday'] = wednesday;
    data['thursday'] = thursday;
    data['friday'] = friday;
    data['saturday'] = saturday?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ScheduleProgram {
  String? host;
  String? text;
  String? time;
  List<String>? images;
  String? programName;
  List<int>? daysOfTheWeek;

  ScheduleProgram(
      {this.host,
      this.text,
      this.time,
      this.images,
      this.programName,
      this.daysOfTheWeek});

  ScheduleProgram.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    text = json['text'];
    time = json['time'];
    images = List<String>.from(json['images']);
    programName = json['program_name'];
    daysOfTheWeek = List<int>.from(json['days_of_the_week']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host'] = host;
    data['text'] = text;
    data['time'] = time;
    data['images'] = images;
    data['program_name'] = programName;
    data['days_of_the_week'] = daysOfTheWeek;
    return data;
  }
}
