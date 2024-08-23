import 'package:itatiaia_app/core/index.dart';
import 'package:itatiaia_app/core/models/search_model.dart';

class SearchRepository implements Repository<SearchPayload> {
  final InterfaceHttpClient client;

  SearchRepository(this.client);

  @override
  Future<BaseResponse> create(SearchPayload model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(SearchPayload model) {
    throw UnimplementedError();
  }

  @override
  Future<SearchPayload?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<SearchPayload>> listAll() async {
    throw UnimplementedError();
  }

  Future<SearchModel> query(String text, {int offset = 1}) async {
    final response = await client.get(
      BaseRequest(
          url:
              'https://www.itatiaia.com.br/app/articles/search?headline=$text&offset=$offset',
          path: ''),
    );
    if (response.success) {
      return SearchModel.fromJson(response.data);
    }
    return SearchModel(payload: []);
  }

  @override
  Future<BaseResponse> update(SearchPayload model) {
    throw UnimplementedError();
  }
}
