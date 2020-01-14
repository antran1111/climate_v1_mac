import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climate_v1_mac/services/location.dart';
import 'package:climate_v1_mac/services/networking.dart';

const apiKey = "d4e56fccca9313967f79eb1b87191202";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = (location.latitude);
    longitude = (location.longitude);

    NetworkHelper networkHelper = NetworkHelper('https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey')
;
    var weatherData = await networkHelper.getData();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocationData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
