import 'dart:convert';

import 'package:itatiaia_app/core/index.dart';

class HomeRepository implements Repository<MenuHomeModel> {
  final InterfaceHttpClient client;

  HomeRepository(this.client);

  @override
  Future<BaseResponse> create(MenuHomeModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(MenuHomeModel model) {
    throw UnimplementedError();
  }

  @override
  Future<MenuHomeModel?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<MenuHomeModel>> listAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> update(MenuHomeModel model) {
    throw UnimplementedError();
  }

  Future<List<MenuHomeModel>> menu() async {
    final response = await client.get(
      BaseRequest(
          path: '',
          url:
              'https://www.itatiaia.com.br/app/home/menu?name=menu-novo-app-itatiaia'),
    );
    if (response.success) {
      return (response.data as List)
          .map((e) => MenuHomeModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<CityModel?> cities() async {
    final response = await client.get(BaseRequest(path: ApiHome.cities));
    if (response.success) {
      return CityModel.fromJson(response.data);
    }
    return null;
  }

  Future<CityScheduleModel?> schedule(String city) async {
    final response =
        await client.get(BaseRequest(path: ApiHome.schedule(city)));
    if (response.success) {
      return CityScheduleModel.fromJson(response.data);
    }
    return null;
  }

  Future<ScheduleNowModel?> scheduleNow(String city) async {
    final response =
        await client.get(BaseRequest(path: ApiHome.scheduleNow(city)));
    if (response.success) {
      return ScheduleNowModel.fromJson(response.data);
    }
    return null;
  }

  saveCurrentRadio(CityPayload model) {
    StorageManager().setString('current_city', json.encode(model.toJson()));
  }

  Future<CityPayload?> currentRadio() async {
    final jsonStr = await StorageManager().getString('current_city');
    if (jsonStr == null) return null;

    return CityPayload.fromJson(json.decode(jsonStr));
  }
}
