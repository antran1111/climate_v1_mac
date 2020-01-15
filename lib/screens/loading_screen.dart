import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climate_v1_mac/services/location.dart';
import 'package:climate_v1_mac/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "d4e56fccca9313967f79eb1b87191202";
const openWeatherMapURL2 = "https://api.openweathermap.org/data/2.5/weather"; //this link doesn't work , request 400, bad
const openWeatherMapURL = "https://samples.openweathermap.org/data/2.5/weather";

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
   // &units=metric //metric is not working

    /*
    {
    "id": 5391832,
    "name": "San Diego County",
    "country": "US",
    "coord": {
      "lon": -116.800858,
      "lat": 33.033379
    }
  },
     */
   // NetworkHelper networkHelper = NetworkHelper(
    //    '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey');
var lat2 = 33.033379;
var lon2 = -116.800858;
//https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=b6907d289e10d714a6e88b30761fae22
    const sdID = 5391832;
    const sdAPI1= 'https://samples.openweathermap.org/data/2.5/weather?id=$sdID&appid=b6907d289e10d714a6e88b30761fae22';
    const sdAPI2 = 'http://api.openweathermap.org/data/2.5/weather?id=5391832&appid=d4e56fccca9313967f79eb1b87191202';
    NetworkHelper networkHelper = NetworkHelper(
        '$sdAPI1'); //sample api1 works, but api2 does not work
    var weatherData = await networkHelper.getData();

    //move to new screen after downloading data
    //make sure to pass in parameters
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //make a loading indicator so people know something is happening in the background
        //import flutter spin kit package
        body: Center(
      child: SpinKitFoldingCube(
        color: Colors.red,
        size: 100.0,
      ),
    ));
  }
}
