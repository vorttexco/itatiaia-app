import 'package:itatiaia_app/core/models/city_schedule_model.dart';

class ScheduleView {
  final String day;
  final List<ScheduleProgram>? schedules;

  ScheduleView({required this.day, required this.schedules});
}

class WrapperWeekSchedule {
  static List<ScheduleView> toView(CityScheduleModel? model) {
    List<ScheduleView> schedules = [];

    schedules
        .add(ScheduleView(day: 'Segunda', schedules: model?.payload?.monday));
    schedules
        .add(ScheduleView(day: 'Terça', schedules: model?.payload?.tuesday));
    schedules
        .add(ScheduleView(day: 'Quarta', schedules: model?.payload?.wednesday));
    schedules
        .add(ScheduleView(day: 'Quinta', schedules: model?.payload?.thursday));
    schedules
        .add(ScheduleView(day: 'Sexta', schedules: model?.payload?.friday));
    schedules
        .add(ScheduleView(day: 'Sábado', schedules: model?.payload?.saturday));
    schedules
        .add(ScheduleView(day: 'Domingo', schedules: model?.payload?.sunday));

    return schedules;
  }
}
