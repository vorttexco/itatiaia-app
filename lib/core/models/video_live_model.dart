// ignore_for_file: library_prefixes

import 'package:html_unescape/html_unescape.dart';

class VideoLiveModel {
  String? kind;
  String? etag;
  String? regionCode;
  PageInfo? pageInfo;
  List<YoutubeItem>? items;

  VideoLiveModel(
      {this.kind, this.etag, this.regionCode, this.pageInfo, this.items});

  VideoLiveModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    regionCode = json['regionCode'];
    pageInfo =
        json['pageInfo'] == null ? null : PageInfo.fromJson(json['pageInfo']);
    items =
        (json['items'] as List).map((e) => YoutubeItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['regionCode'] = regionCode;
    data['pageInfo'] = pageInfo?.toJson();
    data['items'] = items?.map((e) => e.toJson()).toList();
    return data;
  }
}

class YoutubeItem {
  String? kind;
  String? etag;
  Id? id;
  Snippet? snippet;

  YoutubeItem({this.kind, this.etag, this.id, this.snippet});

  YoutubeItem.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] == null ? null : Id.fromJson(json['id']);
    snippet =
        json['snippet'] == null ? null : Snippet.fromJson(json['snippet']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id?.toJson();
    data['snippet'] = snippet?.toJson();
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? liveBroadcastContent;
  String? publishTime;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.liveBroadcastContent,
      this.publishTime});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = parseHtmlString(json['title']);

    description = json['description'];
    thumbnails = json['thumbnails'] == null
        ? null
        : Thumbnails.fromJson(json['thumbnails']);
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    data['thumbnails'] = thumbnails?.toJson();
    data['channelTitle'] = channelTitle;
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['publishTime'] = publishTime;
    return data;
  }

  String parseHtmlString(String htmlString) {
    var unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }
}

class Thumbnails {
  Thumbnail? medium;
  Thumbnail? high;

  Thumbnails({this.medium, this.high});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    medium = json['medium'] == null ? null : Thumbnail.fromJson(json['medium']);
    high = json['high'] == null ? null : Thumbnail.fromJson(json['high']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['medium'] = medium?.toJson();
    data['high'] = high?.toJson();
    return data;
  }
}

class Thumbnail {
  String? url;
  int? width;
  int? height;

  Thumbnail({this.url, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Id {
  String? kind;
  String? videoId;

  Id({this.kind, this.videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['videoId'] = videoId;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalResults'] = totalResults;
    data['resultsPerPage'] = resultsPerPage;
    return data;
  }
}
