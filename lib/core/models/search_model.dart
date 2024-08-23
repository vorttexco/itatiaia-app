class SearchModel {
  bool? success;
  int? totalArticles;
  int? totalPages;
  int? currentPage;
  List<SearchPayload>? payload;

  SearchModel(
      {this.success,
      this.totalArticles,
      this.totalPages,
      this.currentPage,
      this.payload});

  SearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalArticles = json['totalArticles'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    payload = (json['payload'] as List)
        .map((e) => SearchPayload.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['totalArticles'] = totalArticles;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['payload'] = payload?.map((e) => e.toJson()).toList();
    return data;
  }
}

class SearchPayload {
  String? headline;
  String? url;
  String? slug;
  String? editorialName;
  String? mainImage;
  String? publicationDate;

  SearchPayload(
      {this.headline,
      this.url,
      this.slug,
      this.editorialName,
      this.mainImage,
      this.publicationDate});

  SearchPayload.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    url = json['url'];
    slug = json['slug'];
    editorialName = json['editorial_name'];
    mainImage = json['main_image'];
    publicationDate = json['publication_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['headline'] = headline;
    data['url'] = url;
    data['slug'] = slug;
    data['editorial_name'] = editorialName;
    data['main_image'] = mainImage;
    data['publication_date'] = publicationDate;
    return data;
  }
}
