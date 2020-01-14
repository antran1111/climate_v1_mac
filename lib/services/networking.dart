import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
//change void to future b/c you are using async task
  Future getData() async {
    http.Response response = await http.get(
        //hold down cmd or windows and click on get, open up the get method from the http package file
        '$url');

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
      ;
    } else {
      print(response.statusCode);
    }
  }
}
