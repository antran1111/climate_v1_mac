import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
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
    location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  //getData method is from the http package
/*void getData() {
    get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22')

}*/
//turn getData into an async response
 void getData()  async {
    Response response = await get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22')
;
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
