import 'dart:convert';
import 'package:http/http.dart'
as http;

class NetworkHelper {

  NetworkHelper(this.url);

  final String url;

  void getData() async {
    http.Response response = await http.get(
      //hold down cmd or windows and click on get, open up the get method from the http package file
        '$url');

    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      print(longitude);

      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription);

      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
}
}