class WebviewNavigatorModel {
  final String url;
  final String title;
  final bool showShare;

  WebviewNavigatorModel({
    required this.url,
    required this.title,
    this.showShare = true,
  });
}
