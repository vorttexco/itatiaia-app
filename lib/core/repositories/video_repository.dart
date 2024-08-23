import 'package:itatiaia_app/core/index.dart';

class VideoRepository implements Repository<VideoLiveModel> {
  final InterfaceHttpClient client;
  VideoRepository(this.client);

  String baseUrl =
      'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=${AppConstants.CHANNEL_ID}&key=${AppConstants.YOUTUBE_KEY}&';

  @override
  Future<BaseResponse> create(VideoLiveModel model) {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> delete(VideoLiveModel model) {
    throw UnimplementedError();
  }

  @override
  Future<VideoLiveModel?> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoLiveModel>> listAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> update(VideoLiveModel model) {
    throw UnimplementedError();
  }

  Future<VideoLiveModel?> live() async {
    final url = '${baseUrl}eventType=live&type=video';
    final response = await client.get(
      BaseRequest(path: '', url: url),
    );
    if (response.success) {
      return VideoLiveModel.fromJson(response.data);
    }
    return null;
  }

  Future<VideoLiveModel?> videos(String url) async {
    final response = await client.get(
      BaseRequest(path: '', url: url),
    );
    if (response.success) {
      return VideoLiveModel.fromJson(response.data);
    }
    return null;
  }
}
