import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //as http, makes it easier to use package and not confuse names (get) with other methods
import 'package:geolocator/geolocator.dart' ;
import 'package:climate_v1_mac/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  //getData method is from the http package
/*void getData() {
    get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22')

}*/
//turn getData into an async response
  void getData() async {
    http.Response response = await http.get( //hold down cmd or windows and click on get, open up the get method from the http package file
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
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



      var weatherT = jsonDecode(data) ['main']['temp'];
      print('Temperature: ' + weatherT.toString());

      var weatherH = jsonDecode(data) ['main']['humidity'];
      print('Humidity: $weatherH');

      var weatherL = jsonDecode(data) ['name'];
      print('Location: ' + weatherL);

     // print(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
