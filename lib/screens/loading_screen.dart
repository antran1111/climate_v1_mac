import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climate_v1_mac/services/location.dart';
import 'package:climate_v1_mac/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = "d4e56fccca9313967f79eb1b87191202";
//api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
//"https://samples.openweathermap.org/data/2.5/weather";
//example : api.openweathermap.org/data/2.5/weather?lat=35&lon=139
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";
const oldURL = "https://samples.openweathermap.org/data/2.5/weather";

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
    longitude = (location.longitude); //lat and long is a null thats why it's not working //try test on real device see if it works
    print("latitude:" + latitude.toString());
    print("longitude" + longitude.toString());
   // &units=metric //metric is not working
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey');
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
