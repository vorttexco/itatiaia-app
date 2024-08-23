class VideoMenuModel {
  final int id;
  final String title;
  final String url;

  VideoMenuModel({
    required this.id,
    required this.title,
    required this.url,
  });

  static List<VideoMenuModel> list = [
    VideoMenuModel(
        id: 0,
        title: 'Ao vivo',
        url:
            'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UC9T0ZAarQHL4cJGFzORVsFg&key=AIzaSyBLf-MFDPKbpJRf78HTptwTNmwM5X2adYE&eventType=live&type=video'),
    VideoMenuModel(
        id: 1,
        title: 'Jornalismo',
        url:
            'https://www.googleapis.com/youtube/v3/search?channelId=UC9T0ZAarQHL4cJGFzORVsFg&key=AIzaSyBLf-MFDPKbpJRf78HTptwTNmwM5X2adYE&part=snippet,id&order=date&maxResults=50'),
    VideoMenuModel(
        id: 2,
        title: 'Esporte',
        url:
            'https://www.googleapis.com/youtube/v3/search?channelId=UCezhRry1J2kNRNCdNDHimNA&key=AIzaSyBLf-MFDPKbpJRf78HTptwTNmwM5X2adYE&part=snippet,id&order=date&maxResults=50'),
    VideoMenuModel(
        id: 3,
        title: 'Patrulha',
        url:
            'https://www.googleapis.com/youtube/v3/search?channelId=UC7s_0p8Y5I6DClqN_vMugPw&key=AIzaSyBLf-MFDPKbpJRf78HTptwTNmwM5X2adYE&part=snippet,id&order=date&maxResults=50'),
    VideoMenuModel(
        id: 4,
        title: 'Gastronomia',
        url:
            'https://www.googleapis.com/youtube/v3/search?channelId=UC087-MTJAHTKYdW7kR2ufNw&key=AIzaSyBLf-MFDPKbpJRf78HTptwTNmwM5X2adYE&part=snippet,id&order=date&maxResults=50'),
  ];
}
