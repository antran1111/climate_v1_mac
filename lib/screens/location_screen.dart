import 'package:flutter/material.dart';
import 'package:climate_v1_mac/utilities/constants.dart';
import 'package:climate_v1_mac/services/weather.dart';

class LocationScreen extends StatefulWidget {
  //want to pass on locationWeather paramater from loading screen when initilize this
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  //int condition;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget
        .locationWeather); //use print first to see if variables are returning correct values, then change it later to pass into updateUI
 print(widget.locationWeather);

  }

  void updateUI(dynamic weatherData) {

    //put everything in setState b/c it will change and be updated later
//[VERBOSE-2:ui_dart_state.cc(148)] Unhandled Exception: setState() or markNeedsBuild() called during build.
    //setState(() {

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id']; //condition will only exist based on weather
//int weatherH = weatherData['main']['humidity']; //extra, might not use humidity
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      weatherMessage = weather.getMessage(temperature);
  //  });



    print('temperature: $temperature');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
