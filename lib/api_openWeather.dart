import 'package:http/http.dart' as http;
class ApiOpenWheather{
  String _url  = "http://api.openweathermap.org/data/2.5/weather?q=YourPlace&appid=yourApi";
  Future getWeather()async{
    return await http.get(_url);
  }
}