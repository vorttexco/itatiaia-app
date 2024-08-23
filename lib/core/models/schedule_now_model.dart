class ScheduleNowModel {
  bool? success;
  ScheduleNowPayload? payload;

  ScheduleNowModel({this.success, this.payload});

  ScheduleNowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    payload = json['payload'] == null
        ? null
        : ScheduleNowPayload.fromJson(json['payload']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['payload'] = payload?.toJson();
    return data;
  }
}

class ScheduleNowPayload {
  String? time;
  String? timeEnd;
  String? programName;

  ScheduleNowPayload({this.time, this.timeEnd, this.programName});

  ScheduleNowPayload.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    timeEnd = json['time_end'];
    programName = json['program_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['time_end'] = timeEnd;
    data['program_name'] = programName;
    return data;
  }
}
