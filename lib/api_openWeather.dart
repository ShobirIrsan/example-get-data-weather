import 'package:http/http.dart' as http;
class ApiOpenWheather{
  String _url  = "http://api.openweathermap.org/data/2.5/weather?q=Medan&appid=814ecc4782b770546f968dd8a8c3f571";
  Future getWeather()async{
    return await http.get(_url);
  }
}