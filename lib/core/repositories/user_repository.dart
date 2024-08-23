import 'dart:convert';

import '../../core/managers/storage_manager.dart';
import '../../core/models/user_model.dart';
import '../app/app_constants.dart';
import '../models/base_request.dart';
import '../models/base_response.dart';
import '../network/api_hosts.dart';
import '../network/interface_http_client.dart';
import 'interface_repository.dart';

class UserRepository implements Repository<UserModel> {
  final InterfaceHttpClient client;

  UserRepository(this.client);

  @override
  Future<BaseResponse> create(UserModel model) async {
    final request =
        BaseRequest(path: ApiAuth.auth, body: {'tokens': model.token});
    return await client.post(request);
  }

  @override
  Future<BaseResponse> delete(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> get(String? id) async {
    String? userJson = await StorageManager()
        .getString(AppConstants.SHARED_PREFERENCES_SAVE_USER);

    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson));
  }

  @override
  Future<List<UserModel>> listAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> update(UserModel model) {
    throw UnimplementedError();
  }

  Future<bool> save(UserModel user) async {
    await StorageManager().setString(
        AppConstants.SHARED_PREFERENCES_SAVE_USER, json.encode(user.toJson()));
    return true;
  }

  Future<void> logout() async {}
}
