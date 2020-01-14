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
    //  print(response.body); //where the data is stored
    // print(response.statusCode);
    //gives code 200. 200 means success, 404 is missing., 4xx is client error
    //5xx is server error
    //3xx is private
    //lookup http return status code for more info

    //check for errors
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      print(longitude);

      var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      print(weatherDescription);

      /*     var weatherT = jsonDecode(data) ['main']['temp'];
      print('Temperature: ' + weatherT.toString());

      var weatherH = jsonDecode(data) ['main']['humidity'];
      print('Humidity: $weatherH');

      var weatherL = jsonDecode(data) ['name'];
      print('Location: ' + weatherL);*/
//the way below is easier
      //hoover over data, press control + j to find datatype, dynamic
      //can go to json and change the variable types base on what you see
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
}
}