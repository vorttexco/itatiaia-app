class ApiAuth {
  static const auth = '/members/v1/auth';
}

class ApiHome {
  static const home = 'https://www.itatiaia.com.br/?hidemenu=true';
  static const menu = '/app/home/menu?name=menu-novo-app-itatiaia';
  static const cities = '/portal/cities';
  static schedule(String city) => '/portal/cities/$city/radio/schedule-week';
  static scheduleNow(String city) => '/portal/cities/$city/radio/schedule-now';
}

class ApiStories {
  static const home = '/content/v1/web-stories';
}
